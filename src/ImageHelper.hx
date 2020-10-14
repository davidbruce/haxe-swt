import CompileTime;

#if java
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.graphics.Image;
import java.io.ByteArrayInputStream;
import java.util.Base64;
#end

#if macro
import haxe.macro.Context;
#end

class ImageHelper {
    #if java
    public static function imageFromBase64(base64: String) {
        var decoder = Base64.getDecoder();
        return new ByteArrayInputStream(decoder.decode(base64)); 
    }
    #end
 
    macro public static function load(path: String): ExprOf<String> {
        return  macro {
              ImageHelper.imageFromBase64(CompileTime.readFileAsBase64($v{path}));
        };
    }
}
