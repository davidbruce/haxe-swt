package ;

import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Event;

class ListenerCallback implements Listener {
    var callback: Event->Void;
    public function new(callback:Event->Void) {
        this.callback = callback;
    }
    public function handleEvent(event:Event):Void {
        callback(event);
    }
} 
