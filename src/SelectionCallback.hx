package ;

import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.events.SelectionEvent;

class SelectionCallback implements SelectionListener {
    var callback: SelectionEvent->Void;
    public function new(callback:SelectionEvent->Void) {
        this.callback = callback;
    }
    public function widgetSelected(selectionEvent:SelectionEvent):Void {
        callback(selectionEvent);
    }
    public function widgetDefaultSelected(selectionEvent:SelectionEvent):Void {
        callback(selectionEvent);
    }
} 