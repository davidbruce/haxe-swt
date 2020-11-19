package swt.callbacks;

import org.eclipse.swt.events.PaintListener;
import org.eclipse.swt.events.PaintEvent;

typedef Callback = PaintEvent -> Void;

class PaintCallback implements PaintListener {
    var _paintControl: Callback;
    public function new(callbacks: { ?paintControl: Callback }) {
        _paintControl = callbacks.paintControl;
    }
    public function paintControl(event: PaintEvent): Void {
        _paintControl(event);
    }
    public function setPaintControl(callback: Callback): Void {
        _paintControl = callback;
    }
} 
