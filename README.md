# Haxe SWT
### This is a work in progress.
Library for using the [Eclipse SWT Library](https://www.eclipse.org/swt/) with the Haxe Java target.
Also includes [SWTChart](https://projects.eclipse.org/projects/science.swtchart) Modules:
* org.eclipse.swtchart
* org.eclipse.swtchart.extensions

## Callbacks
A few helper classes for adding Listerners can be found in swt.callbacks.
 
ControlCallback.hx:
```haxe
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
```

Usage:
```haxe
item.addListener ( new ControlCallback(
    {
        controlMoved: e -> {
            trace("Control Moved");
        }
    }
));
```


## Example
Ported from Eclipse Snippet 29. 
```haxe
package; 

import swt.callbacks.ListenerCallback;
import org.eclipse.swt.*;
import org.eclipse.swt.widgets.*;

class Main {

    public static function main() {
	    var display = new Display ();
        var shell = new Shell (display);
        shell.setText("Snippet 29");

        var bar = new Menu (shell, SWT.BAR);
        shell.setMenuBar (bar);

        var fileItem = new MenuItem (bar, SWT.CASCADE);
        fileItem.setText ("&File");
        var submenu = new Menu (shell, SWT.DROP_DOWN);
        fileItem.setMenu (submenu);

        var item = new MenuItem (submenu, SWT.PUSH);
        item.addListener (SWT.Selection, new ListenerCallback(
            {
                handleEvent: e -> {
                    trace("Selected");
                }
            }
        ));
        item.setText ("Select &All\tCtrl+A");
        item.setAccelerator (SWT.MOD1 + 65);
        shell.setSize (200, 200);
        shell.open ();
        while (!shell.isDisposed()) {
            if (!display.readAndDispatch ()) display.sleep ();
        }
        display.dispose ();
    }

}
```