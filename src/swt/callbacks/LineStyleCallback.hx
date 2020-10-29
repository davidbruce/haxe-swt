package swt.callbacks;

import org.eclipse.swt.custom.LineStyleListener;
import org.eclipse.swt.custom.LineStyleEvent;

typedef Callback = LineStyleEvent -> Void;

class LineStyleCallback implements LineStyleListener {
    var _lineGetStyle: Callback;
    public function new(callbacks: { ?lineGetStyle: Callback }) {
        this._lineGetStyle = callbacks.lineGetStyle;
    }
    public function lineGetStyle(event: LineStyleEvent): Void {
        _lineGetStyle(event);
    }
    public function setLineGetStyle(callback: Callback): Void {
        _lineGetStyle = callback;
    }
}
