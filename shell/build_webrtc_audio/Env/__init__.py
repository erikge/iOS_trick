#
# WengoSCons, a high-level library for SCons
#
# Copyright (C) 2004-2005   
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

import SCons.Script
from Env import environment

#Global functions

try:
	gdict = SCons.Script._SConscript.GlobalDict
except AttributeError:    
	gdict =  SCons.Script.SConscript.GlobalDict

gdict['GlobalGetEnvironment'] = environment.GlobalGetEnvironment
gdict['GlobalGetQt3Environment'] = environment.GlobalGetQt3Environment
gdict['GlobalGetQt4Environment'] = environment.GlobalGetQt4Environment

gdict['GlobalGetRootBuildDir'] = environment.GlobalGetRootBuildDir

gdict['GlobalCCGCC'] = environment.GlobalCCGCC
gdict['GlobalCCMinGW'] = environment.GlobalCCMinGW
gdict['GlobalCCMSVC'] = environment.GlobalCCMSVC

gdict['GlobalOSWindows'] = environment.GlobalOSWindows
gdict['GlobalOSWindowsCE'] = environment.GlobalOSWindowsCE
gdict['GlobalOSLinux'] = environment.GlobalOSLinux
gdict['GlobalOSMacOSX'] = environment.GlobalOSMacOSX
gdict['GlobalOSBSD'] = environment.GlobalOSBSD
gdict['GlobalOSPosix'] = environment.GlobalOSPosix

gdict['GlobalArchX86'] = environment.GlobalArchX86
gdict['GlobalArchPPCMacintosh'] = environment.GlobalArchPPCMacintosh

gdict['GlobalGetConsoleArgument'] = environment.GlobalGetConsoleArgument
gdict['GlobalAddConsoleArguments'] = environment.GlobalAddConsoleArguments

gdict['GlobalShowWindowsConsole'] = environment.GlobalShowWindowsConsole

gdict['GlobalSetVariable'] = environment.GlobalSetVariable
gdict['GlobalGetVariable'] = environment.GlobalGetVariable

gdict['GlobalDebugMode'] = environment.GlobalDebugMode
gdict['GlobalReleaseMode'] = environment.GlobalReleaseMode
gdict['GlobalReleaseSymbolsMode'] = environment.GlobalReleaseSymbolsMode

gdict['GlobalGetSubversionRevision'] = environment.GlobalGetSubversionRevision
gdict['GlobalGetCurrentDateTime'] = environment.GlobalGetCurrentDateTime

