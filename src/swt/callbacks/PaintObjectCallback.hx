package swt.callbacks;

import org.eclipse.swt.custom.PaintObjectListener;
import org.eclipse.swt.custom.PaintObjectEvent;

typedef Callback = PaintObjectEvent -> Void;

class PaintObjectCallback implements PaintObjectListener {
    var _paintObject: Callback;
    public function new(callbacks: { ?paintObject: Callback }) {
        _paintObject = callbacks.paintObject;
    }
    public function paintObject(event:PaintObjectEvent): Void {
        _paintObject(event);
    }
    public function setPaintObject(callback: Callback): Void {
        _paintObject = callback;
    }
}
