package swt.callbacks;

import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.events.SelectionEvent;

typedef Callback = SelectionEvent -> Void;

class SelectionCallback implements SelectionListener {
    var _widgetSelected: Callback;
    var _widgetDefaultSelected: Callback;
    public function new(callbacks: { ?widgetSelected: Callback, ?widgetDefaultSelected: Callback }) {
        _widgetSelected = callbacks.widgetSelected;
        _widgetDefaultSelected = callbacks.widgetDefaultSelected; 
    }
    public function widgetSelected(event: SelectionEvent): Void {
        _widgetSelected(event);
    }
    public function widgetDefaultSelected(event: SelectionEvent): Void {
        _widgetDefaultSelected(event);
    }
    public function setWidgetSelected(callback: Callback): Void {
        _widgetSelected = callback;
    }
    public function setWidgetDefaultSelected(callback: Callback): Void {
        _widgetDefaultSelected = callback;
    }
} 