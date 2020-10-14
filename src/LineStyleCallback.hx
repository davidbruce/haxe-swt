package ;

import org.eclipse.swt.custom.LineStyleListener;
import org.eclipse.swt.custom.LineStyleEvent;

class LineStyleCallback implements LineStyleListener {
    var callback: LineStyleEvent->Void;
    public function new(callback:LineStyleEvent->Void) {
        this.callback = callback;
    }
    public function lineGetStyle(event:LineStyleEvent):Void {
        callback(event);
    }
}
