import sets, os, time, sys
from SCons.Environment import Environment

Set = sets.Set

class CompInfo:

    def __init__(self, name, includes = [], libpathes = [], libs = [] , uses = [], node = None):
        self.name = name
        self.includes = sets.ImmutableSet(includes)
        self.libpathes = sets.ImmutableSet(libpathes)
        self.libs = sets.ImmutableSet(libs)
        self.depends = uses
        self.node = node

    def use(self, env):
        """ add to the given environement information needed to use this moduel"""

        dict = env.Dictionary()
        
        def evar(k):
            if dict.has_key(k):
                return dict[k]

            return []


            
        env.AppendUnique(LIBPATH = list(self.libpathes))
        env.AppendUnique(CPPPATH = list(self.includes))
        env.AppendUnique(LIBS = list(self.libs))
            
        # print "Preparing for:", self.name, " libs=", self.libs 
        for m in self.depends:
            m.use(env)
 

class BuildJobInfo:

    
    def __init__(self, opts):


          env = Environment(options = opts)
          env.Help(opts.GenerateHelpText(env))
          self.static_objs = []
          self.env = env
          self.debug = env["debug"]
          self.targetos = env["target_os"]
          self.targetArch = env["target_arch"]
          self.iosarmv7 = env["iosarmv7"]
          self.archx64 = env["x64"]
          self.buildpath = "."
          self.installpath = "."
          self.optimization_flags = ""
          self.asm_as = ""
		  
          if "CC" in os.environ.keys():
              self.cc = os.environ['CC']
          else:
              self.cc = env["CC"]
              
          if "CFLAGS" in os.environ.keys():
              self.cf = os.environ['CFLAGS']
          else:
              self.cf = []
          
#          print "self CFLAGS is ", self.cf

          
          self.armlinuxTarget = "arm-linux" in self.cc
          
          if not self.armlinuxTarget:
             self.linuxTarget = "linux" in self.targetos
          else:   
             self.linuxTarget = 0
             
          self.win32Target = self.targetos == "win32"
          self.posixTarget = self.targetos in [ "linux", "osx", 'iphone', 'iphonesim' ]
          self.osxTarget =  self.targetos == "osx"
          self.bsdTarget = "BSD" in self.targetos
          self.iphone = "iphone" in self.targetos

          if self.osxTarget:
              if self.archx64:
                  self.cf += ['-arch', 'x64']
              else:
                  self.cf += ['-arch', 'i386']

          if self.iphone:
              SDKVER = '6.1'
              IOS_ARCH = 'armv7'
              if ("armv7s" in self.targetArch):
                  IOS_ARCH = 'armv7s'
              elif ("armv7" in self.targetArch):
                  IOS_ARCH = 'armv7'
              elif ("armv6" in self.targetArch):
                  IOS_ARCH = 'armv6'
              else:
                  IOS_ARCH = 'armv7'

              if ("sim" in self.targetos):
                  iOS = 'Simulator'
                  iARCH='i686-apple-darwin10-'
                  iCCVER = '-4.0.1'
                  iGCCincs = "/usr/include/c++/4.0.0/i686-apple-darwin10"
              else:
                  iOS = 'OS'
                  iARCH='arm-apple-darwin10-'
                  iCCVER = '-4.0.1'
                  iGCCincs = '/usr/include/c++/4.2.1/arm-apple-darwin10'

              PLATFORM = 'iPhone' + iOS + '.platform'
              XCODE_ROOT = '/Applications/Xcode.app/Contents/Developer'
              DEVPLATFORM = XCODE_ROOT + '/Platforms/' + PLATFORM
              SDK = DEVPLATFORM + '/Developer/SDKs/iPhone' + iOS + SDKVER + '.sdk'
              
              self.cc = '/Applications/XCode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/../../../Toolchains/XcodeDefault.xctoolchain/usr/bin/clang'
               #DEVPLATFORM + '/Developer/usr/bin/gcc'  # + iARCH + 'gcc' + iCCVER
              self.asm_as  = DEVPLATFORM + '/Developer/usr/bin/as -arch '+IOS_ARCH
              self.cf  = [
                  '-std=c99',
                  '-Diphoneos_version_min=4.0',
                  '-isysroot '+SDK,
                  '-DWEBRTC_TARGET_PC',
                  '-DWEBRTC_THREAD_RR',
                  '-DWEBRTC_CLOCK_TYPE_REALTIME',
                  '-DWEBRTC_MAC',
                  '-DMAC_IPHONE',
                  '-DWEBRTC_IOS',
                  '-DTEST_MACRO',
                  '-D__STDC_FORMAT_MACROS',
                  '-arch '+IOS_ARCH,
                  '-mcpu=cortex-a8',
                  '-flax-vector-conversions',
                  '-mfpu=neon',
                  '-mfloat-abi=softfp',
                  '-DWEBRTC_ARM_INLINE_CALLS',
                  '-DWEBRTC_ARCH_ARM_NEON',
                  '-DWEBRTC_ARCH_ARM',
                  '-DWEBRTC_ARCH_ARM_V7',
                  '-DENABLE_VIDEO',
                          
                          "-Drestrict=''",
                          '-D__EMX__',
                          '-DOPUS_BUILD',
                          '-DFIXED_POINT',
                          '-DUSE_ALLOCA',
                          '-DHAVE_LRINT',
                          '-DHAVE_LRINTF',
                          #'-O3',
                          #'-fno-math-errno',
                  ]

              self.cxx  = '/Applications/XCode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/../../../Toolchains/XcodeDefault.xctoolchain/usr/bin/clang'
              #DEVPLATFORM + '/Developer/usr/bin/g++' # + iARCH + 'g++' + iCCVER

          if self.osxTarget:
                    self.cf += [ 
                    '-DWEBRTC_TARGET_PC',
                    '-DWEBRTC_MAC',
                    '-DWEBRTC_MAC_INTEL',
                    '-DWEBRTC_TARGET_MAC_INTEL',
                    '-DWEBRTC_CLOCK_TYPE_REALTIME',
                    '-DWEBRTC_THREAD_RR',
                    '-D__STDC_FORMAT_MACROS',
                    '-DTEST_MACRO',
                    '-DENABLE_VIDEO',
                    ]

          self.msvc = self.cc == "cl"
          self.gcc =  ("gcc" in self.cc) or ("mingw" in self.cc) 
          self.mingw =  "mingw" in self.cc
          self.components = { }
          self.opts = opts
          
          if self.armlinuxTarget:
               os_name = self.buildpath = "ARM_Linux"
          elif self.mingw:
              os_name = self.buildpath = "Mingw"
          elif self.win32Target:
              os_name = self.buildpath = "Windows"
          elif self.osxTarget:
              os_name = self.buildpath = "MacOS"
          elif self.linuxTarget:
               os_name = self.buildpath = "Linux"
          elif self.iphone:
              os_name = self.buildpath = 'iOS'
			  
          self.buildpath = "build_" + self.buildpath + "_vctl"

          if self.win32Target:
                    self.cf += [ 
                    '-D_CRT_SECURE_NO_DEPRECATE',
                    '-D_LIB',
                    '-DUNICODE',
                    '-DWIN32',
                    ]
		  
		  
          if self.msvc:
                    lib_optimization_flags = [
                    '/Ox',
                    '/Ob2',
                    '/Oi',
                    '/Ot',
                    '/Oy',
                    '/G7',
                    '/GX-',
                    '/GR-' ,
                    '/arch:SSE'
                    ]
          else:
                    if self.armlinuxTarget:
                         lib_optimization_flags = [ '-Os' ]
                    else:
                         lib_optimization_flags = [ '-O3' ]


          self.optimization_flags = lib_optimization_flags

          if self.debug:
              self.buildpath += "_Debug"
              self.cf += [ '-g' ]
              self.cf += [ '-W' ]
              self.cf += [ '-D_DEBUG' ]
          else:
              self.cf += [ '-fvisibility=hidden', '-DWEBRTC_NO_TRACE','-DNDEBUG' ]
              self.buildpath += "_Release"
              self.cf += self.optimization_flags


          self.buildpath += "/build/" + IOS_ARCH
          self.installpath = "invalid"

          self.sharedtarget = False
#-fvisibility=hidden',

    def Component(self, name, includes = [], libpath = [], libs = [], uses = [], node = None): 
          if self.components.has_key(name):
              return self.components[name]

          def compinfo(x):
              if isinstance(x, CompInfo):
                  return x
              
              if not x in self.components.keys():
                  self.components[x] = CompInfo(x, libs = [ x ])
                  
              return self.components[x]

          if uses and len(uses):
              newuses = [ compinfo(x) for x in uses ]
          else:
              newuses = []

          if node:
              self.env.Alias(name, node)

          if node:
              if len(libpath) == 0:
                  libpath = [node[0].dir]
              if len(libs) == 0:
                  libs = [name]
                  
          m = CompInfo(name, includes, libpath, libs, newuses, node)
          self.components[name] = m
          if node:
              self.env.Alias(name, node)

          return m


    def CompNode(self, name):
        return self.components[name].node
    
    
    def Use(self, env,  uses, USEDEBUG=False):

          dict = env.Dictionary()
          def showprep(msg):
              l = []
              for k in ["CPPPATH", "LIBPATH", "LIBS"]:
                  v = ""
                  if dict.has_key(k):
                      v = dict[k]
                  l += [(k,v)]    
              print msg, l

          #showprep("Before preparing")
          usedComponents = [ self.components[x] for x in ( Set(uses) & Set(self.components.keys())) ]
          for m in usedComponents:
              m.use(env)

          stdlibs = Set(uses) - Set(self.components.keys()) 
          env.AppendUnique(LIBS = list(stdlibs))
          
          
          #showprep("After preparing")




    def NewEnv(self):
    	  env = Environment(options = self.opts)
    	  env['CC'] = self.cc
    	  env['AS'] = self.asm_as

          if self.iphone:
              env['CXX'] = self.cxx
              env['LINK'] = env['CXX']
              env.MergeFlags(self.cf)
	      if self.debug:
		env.Replace(RANLIB='/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ranlib')
		env.Replace(AR='/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ar')


          if self.osxTarget:
              env.AppendENVPath('PATH', '/opt/local/bin')
              env.Append( CCFLAGS = self.cf )

          if self.armlinuxTarget:
              env.Append( CCFLAGS = self.cf )

          if self.debug and self.linuxTarget:
              env.Append(CCFLAGS = "-g")
              
              
          if self.win32Target:
              # print "preparing for Win32" 
              env['CC']=self.cc
              env.Append( CPPDEFINES = { 'WIN32' : 1, '_WIN32' : 1 } )
          if self.msvc:
              debug = ""
              if self.debug:
                  debug = "d"
                  #env.AppendUnique(LINKFLAGS = [ "/DEBUG", "/MAP", "/NODEFAULTLIB:LIBC.LIB" ])
		  env.Append(CCFLAGS = ['-Zi', '/LDd', '-Gm', '/DEBUG', '-D_DEBUG', '/MTd'])
		  env.AppendUnique(LINKFLAGS = ['/DEBUG', '/NODEFAULTLIB:MSVCRT.LIB'])
		  env.AppendUnique(SHCCFLAGS = "/MT" + debug, SHCXXFLAGS = "/MT" + debug)

          return env  


    def Autoconf(self, env, moduleName, outputFiles,
                       configureCommand = './configure', makeCommand = 'make',
                       configureFiles = 'configure', makeFiles = 'Makefile',
                       uses = None, includes = None, libpath = None, libs = None):
        """
        Build a library using autotools: configure and make.
        
        Algorithm:
        - Launch the configure command
        - Launch the make command
        - Declare the library as an internal library
        
        @type libraryName string
        @param libraryName name of the library to compile
        @type outputFiles stringlist
        @param outputFiles list of awaited files (.a, .so, .dll, .dylib...)
        @type configureCommand string
        @param configureCommand command line for 'configure' (e.g './configure --enable-gtk --disable-blahblah')
        @type makeCommand string
        @param makeCommand command line for 'make' (e.g 'make blahblah')
        @type configureFiles string
        @param configureFiles files needed by configure (e.g the configure script 'configure' is needed by configure)
        @type makeFiles string
        @param makeFiles files needed by male (e.g the file 'Makefile' is needed by make)
        """

        
        bldDir = env.Dir(".").path

        makefile = env.Command(makeFiles, configureFiles,
					'cd ' + bldDir + ' && ' + configureCommand)
        make = env.Command(outputFiles, makeFiles,
					'cd ' + bldDir + ' && ' + makeCommand)

        env.Depends(make, makefile)
        #self.Component(moduleName, includes, libpath, libs, uses)
        env.Alias(moduleName, [make])
        


    def Plugin(self, env, target, source, **kw):
        lib = None
        try:
           #SCons 0.96.91 support (pre-release for 0.97)
           tmp = env['LDMODULEPREFIX']
           #Removes the library name prefix
           env['LDMODULEPREFIX'] = ''
           lib = env.LoadableModule(target, source, **kw)
           env['LDMODULEPREFIX'] = tmp
        except KeyError:
           #SCons 0.96.1 support (stable version)
           tmp = env['SHLIBPREFIX']
           #Removes the library name prefix
           env['SHLIBPREFIX'] = ''
           lib = env.SharedLibrary(target, source, **kw)
           env['SHLIBPREFIX'] = tmp
        
        return lib
   
    def LibraryMerge(self, env, target):
       lib = env.StaticLibrary( target, self.static_objs )
       return lib

    def AddObjs(self, env, objs):
       self.static_objs += objs
      
    def Library(self, env, target, source = None, uses = [], includes = [], libpath = [], libs = [],  sharedtarget = None, asm_objs =  None,**kw):

        if sharedtarget == None:
            sharedtarget = self.sharedtarget


        self.Use(env, uses)
        env.AppendUnique( **kw )
        if sharedtarget:
            obj = env.SharedObject( source = source)
        else:
            obj = env.StaticObject( source = source)

        if asm_objs != None:
            obj += asm_objs

        if self.static_objs == None:
           self.static_objs = obj 
        else:
           self.static_objs += obj

        lib = env.StaticLibrary( target, obj )
        self.Component(target, includes = includes, libpath = libpath, libs = libs, uses = uses, node = lib)

        return lib


    def SharedLibrary(self, env, target, source,  uses = [], includes = [], libpath = [], libs = [],  **kw):

        self.Use(env, uses)
        env.AppendUnique( **kw )
        lib = env.SharedLibrary( target, source = source )
        self.Component(target, includes = includes, libpath = libpath, libs = libs, uses = uses, node = lib)
	#vcproj = env.MSVSProject(target=target+env['MSVSPROJECTSUFFIX'], srcs = source, incs = includes, buildtarget = lib,
	#			variant = 'Debug')
	#env.Depends(target, vcproj)

        return lib
