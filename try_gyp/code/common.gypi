{
    'variables': {

    }, # end variables
    'target_defaults': {
        'conditions': [
            ['OS=="iOS"', { # iOS platform
                'xcode_settings': {
                    'SDKROOT': 'iphoneos',
                    'TARGETED_DEVICE_FAMILY': '1,2',
                    'CODE_SIGN_IDENTITY': 'iPhone Developer',
                    'IPHONEOS_DEPLOYMENT_TARGET': '5.0',
                    'ARCHS': '$(ARCHS_STANDARD_32_64_BIT)',
                },
            }],
            ['OS=="android"', { # android platform
                # TODO
            }],
            ['OS=="linux"', {
                'defines': ['__unix__', '_LINUX'],
                'cflags': ['-Wall']
            }],
            ['OS=="win"', {
                'defines': ['WIN32'],
                'msvs_configuration_attributes': {'CharacterSet': '1'},
                'msvs_settings': {
                    'VCCLCompilerTool': {
                        'WarningLevel': '4',
                        'Detect64BitPortabilityProblems': 'true'
                    }
                }
            }],
            ['OS=="mac"', {
                'defines': ['__unix__', '_MACOS'],
                'cflags': ['-Wall']
            }]
        ], # end conditions OS

        'configurations': {
            'Debug': {
                'defines': ['_DEBUG'],

                'conditions': [
                    ['OS=="linux" or OS=="freebsd" or OS=="openbsd"', {
                        'cflags': ['-g']
                    }],
                    ['OS=="win"', {
                        'msvs_settings': {
                            'VCCLCompilerTool': {
                                'Optimization': '0',
                                'MinimalRebuild': 'true',
                                'BasicRuntimeChecks': '3',
                                'DebugInformationFormat': '4',

                                'conditions': [
                                    ['library=="shared_library"', {
                                        'RuntimeLibrary': '3'  # /MDd
                                    }, {
                                        'RuntimeLibrary': '1'  # /MTd
                                    }]
                                ]
                            },
                            'VCLinkerTool': {
                                'GenerateDebugInformation': 'true',
                                'LinkIncremental': '2'
                            }
                        } # end msvs_settings
                    }],
                    ['OS=="mac" or OS=="iOS"', {
                        'xcode_settings': {
                            'GCC_GENERATE_DEBUGGING_SYMBOLS': 'YES'
                        }
                    }]
                ]
            }, # end Debug

            'Release': {
                'conditions': [
                    ['OS=="linux" or OS=="freebsd" or OS=="openbsd"', {
                        'cflags': ['-O3']
                    }],
                    ['OS=="win"', {
                        'msvs_settings': {
                            'VCCLCompilerTool': {
                                'Optimization': '2',

                                'conditions': [
                                    ['library=="shared_library"', {
                                        'RuntimeLibrary': '2'  # /MD
                                    }, {
                                        'RuntimeLibrary': '0'  # /MT
                                    }]
                                ]
                            }
                        } # end msvs_settings
                    }],
                    ['OS=="mac" or OS=="iOS"', {
                        'xcode_settings': {
                            'GCC_GENERATE_DEBUGGING_SYMBOLS': 'NO',
                            'GCC_OPTIMIZATION_LEVEL': '3',

                            # -fstrict-aliasing. Mainline gcc enables
                            # this at -O2 and above, but Apple gcc does
                            # not unless it is specified explicitly.
                            'GCC_STRICT_ALIASING': 'YES'
                        }
                    }]
                ]
            } # end Release
        } # end configurations
    }, # end target_defaults
}