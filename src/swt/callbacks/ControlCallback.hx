package swt.callbacks;

import org.eclipse.swt.events.ControlListener;
import org.eclipse.swt.events.ControlEvent;

typedef Callback = ControlEvent -> Void;

class ControlCallback implements ControlListener {
    var _controlMoved: Callback;
    var _controlResized: Callback;
    public function new(callbacks: { ?controlMoved: Callback, ?controlResized: Callback }) {
        _controlMoved = callbacks.controlMoved;
        _controlResized = callbacks.controlResized;
    }
    public function controlMoved(event:ControlEvent): Void {
        _controlMoved(event);
    }
    public function controlResized(event:ControlEvent): Void {
        _controlResized(event);
    }
    public function setControlMoved(callback:Callback): Void {
        _controlMoved = callback;
    }
    public function setControlResized(callback:Callback): Void {
        _controlResized = callback;
    }
}

