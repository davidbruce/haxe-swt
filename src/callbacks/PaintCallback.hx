package ;

import org.eclipse.swt.events.PaintListener;
import org.eclipse.swt.events.PaintEvent;

class PaintCallback implements PaintListener {
    var callback: PaintEvent->Void;
    public function new(callback:PaintEvent->Void) {
        this.callback = callback;
    }
    public function paintControl(paintEvent:PaintEvent):Void {
        callback(paintEvent);
    }
} 
