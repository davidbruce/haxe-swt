package ;

import haxe.ds.IntMap;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.graphics.GC;
// import hx.concurrent.executor.*;


class Main {
    function new() {
        var display = new Display ();
        var shell = new Shell (display);
        var curX = 0, curY = 0, lastX = 0, lastY = 0;
        var listener = new ListenerCallback (e -> {
            if (e.type == SWT.MouseMove) {
                curX = e.x;
                curY = e.y;
            } 
            if (e.type == SWT.MouseDown) {
            }
            if(e.type == SWT.MouseUp) {
            }
            if (e.type == SWT.MouseDown || e.type == SWT.MouseMove) {
                shell.redraw();
            }
            if(e.type == SWT.Paint) {
                var rect = shell.getClientArea();
                e.gc.drawText(curX + "," + curY, 0,0);
                e.gc.drawOval(0, 0, rect.width - 1, rect.height - 1);
                e.gc.drawLine(0, 0, lastX, lastY);
            }
        });

        shell.addListener(SWT.MouseMove, listener);
        shell.addListener(SWT.MouseDown, listener);
        shell.addListener(SWT.MouseUp, listener);
        shell.addListener(SWT.Paint, listener);

        var clientArea = shell.getClientArea();
        shell.setBounds(clientArea.x + 10, clientArea.y + 10, 200, 200);
    
        shell.open ();
        while (!shell.isDisposed ()) {
            if (!display.readAndDispatch ()) display.sleep ();
        }
        display.dispose ();
    }

    public static function main() {
       // new Snippet232();
        new Snippet29();
    }
}
