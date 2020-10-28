package ;

import org.eclipse.swt.custom.MovementListener;
import org.eclipse.swt.custom.MovementEvent;

class MovementCallback implements MovementListener {
    var callback: MovementEvent->Void;
    public function new(callback:MovementEvent->Void) {
        this.callback = callback;
    }
    public function getNextOffset(movementEvent:MovementEvent):Void {
        callback(movementEvent);
    }
    public function getPreviousOffset(movementEvent:MovementEvent):Void {
        callback(movementEvent);
    }
}
