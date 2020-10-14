package ;

import org.eclipse.swt.custom.PaintObjectListener;
import org.eclipse.swt.custom.PaintObjectEvent;

class PaintObjectCallback implements PaintObjectListener {
    var callback: PaintObjectEvent->Void;
    public function new(callback:PaintObjectEvent->Void) {
        this.callback = callback;
    }
    public function paintObject(paintObjectEvent:PaintObjectEvent):Void {
        callback(paintObjectEvent);
    }
}
