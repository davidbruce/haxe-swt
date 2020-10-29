package swt.callbacks;

import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Event;

typedef Callback = Event -> Void;

class ListenerCallback implements Listener {
    var _handleEvent: Callback;
    public function new(callbacks: { ?handleEvent: Callback }) {
        _handleEvent = callbacks.handleEvent;
    }
    public function handleEvent(event: Event): Void {
        _handleEvent(event);
    }
    public function setHandleEvent(callback: Callback): Void {
        _handleEvent = callback;
    }
} 