package swt._internal;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.io.Path;

class ExtraParams {
    public static function includeJars(): Void {
        var getPath = function( ?pos:haxe.PosInfos ) {
            return Path.directory(pos.fileName);
        }
        
        if (Context.defined("windows")) {
            Compiler.addNativeLib(getPath() + "/jars/win");
        }
        else if (Context.defined("linux")) {
            Compiler.addNativeLib(getPath() + "/jars/gtk");
        }
        else if (Context.defined("osx")) {
            Compiler.addNativeLib(getPath() + "/jars/osx");
        } else {
            throw "\nAn OS needs to be defined with -D.  options: windows, linux, osx";
        }

        Compiler.addNativeLib(getPath() + "/jars/common");
    }
}