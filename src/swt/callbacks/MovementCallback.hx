package swt.callbacks;

import org.eclipse.swt.custom.MovementListener;
import org.eclipse.swt.custom.MovementEvent;

typedef Callback = MovementEvent -> Void;

class MovementCallback implements MovementListener {
    var _getNextOffset: Callback;
    var _getPreviousOffset: Callback;
    public function new(callbacks: { ?getNextOffset: Callback, ?getPreviousOffset: Callback }) {
        _getNextOffset: callbacks.getNextOffset;
        _getPreviousOffset: callbacks.getPreviousOffset;
    }
    public function getNextOffset(event:MovementEvent): Void {
        callback(event);
    }
    public function getPreviousOffset(event:MovementEvent): Void {
        callback(event);
    }
    public function setGetNextOffset(callback:Callback): Void {
        _getNextOffset = callback;
    }
    public function setGetPreviousOffset(callback:Callback): Void {
        _getPreviousOffset = callback;
    }
}
