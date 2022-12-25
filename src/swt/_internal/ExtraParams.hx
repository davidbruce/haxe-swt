package swt._internal;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.io.Path;

class ExtraParams {
    public static function includeJars(): Void {
        var getPath = function( ?pos:haxe.PosInfos ) {
            return Path.directory(pos.fileName);
        }
        
        var arch = '';
        if (Context.defined("x86-64")) {
            arch = "x86-64";
        } else if (Context.defined("aarch64")) {
            arch = "aarch64";
        } else {
            throw "\nAn architecture needs to be defined with -D.  options: x86-64, aarch64  note: windows aarch64 not supported";
        }

        if (Context.defined("windows")) {
            Compiler.addNativeLib(getPath() + "/jars/" + arch + "/windows");
        }
        else if (Context.defined("linux")) {
            Compiler.addNativeLib(getPath() + "/jars/" + arch + "/linux");
        }
        else if (Context.defined("macos")) {
            Compiler.addNativeLib(getPath() + "/jars/" + arch + "/macos");
        } else {
            throw "\nAn OS needs to be defined with -D.  options: windows, linux, macos";
        }

        Compiler.addNativeLib(getPath() + "/jars/common");
    }
}