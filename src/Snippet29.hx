import org.eclipse.swt.*;
import org.eclipse.swt.widgets.*;

class Snippet29 {

    public function new() {
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
        item.addListener (SWT.Selection, new ListenerCallback(e ->{ trace("Select All"); }));
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
