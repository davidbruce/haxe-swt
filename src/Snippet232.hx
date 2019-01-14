import org.eclipse.swt.*;
import org.eclipse.swt.graphics.*;
import org.eclipse.swt.layout.*;
import org.eclipse.swt.widgets.*;

using Lambda;
class Snippet232 {

    public function new() {
        var display = new Display();
        var shell = new Shell(display);
        shell.setLayout(new FillLayout());
        shell.setText("Show results as a bar chart in Tree");
        var tree = new Tree(shell, SWT.BORDER);
        tree.setHeaderVisible(true);
        tree.setLinesVisible(true);
        var column1 = new TreeColumn(tree, SWT.NONE);
        column1.setText("Bug Status");
        column1.setWidth(100);
        var column2 = new TreeColumn(tree, SWT.NONE);
        column2.setText("Percent");
        column2.setWidth(200);
        var states = ["Resolved", "New", "Won't Fix", "Invalid"];
        var teams = ["UI", "SWT", "OSGI"];
        for (team in teams) {
            var item = new TreeItem(tree, SWT.NONE);
            item.setText(team);
            for (state in states) {
                var subItem = new TreeItem(item, SWT.NONE);
                subItem.setText(state);
            }
        }

        /*
        * NOTE: MeasureItem, PaintItem and EraseItem are called repeatedly.
        * Therefore, it is critical for performance that these methods be
        * as efficient as possible.
        */

        var percents = [50, 30, 5, 15];
        tree.addListener(SWT.PaintItem, new ListenerCallback(event -> {
            if (event.index == 1) {
                var item = cast (event.item, TreeItem);
                var parent = item.getParentItem();
                if (parent != null) {
                    var gc = event.gc;
                    var index = parent.indexOf(item);
                    var percent = percents[index];
                    var foreground = gc.getForeground();
                    var background = gc.getBackground();
                    gc.setForeground(display.getSystemColor(SWT.COLOR_RED));
                    gc.setBackground(display.getSystemColor(SWT.COLOR_YELLOW));
                    var width = cast((column2.getWidth() - 1) * percent / 100, Int);
                    gc.fillGradientRectangle(event.x, event.y, width, event.height, true);
                    var rect2 = new Rectangle(event.x, event.y, width-1, event.height-1);
                    gc.drawRectangle(rect2);
                    gc.setForeground(display.getSystemColor(SWT.COLOR_LIST_FOREGROUND));
                    var text = percent+"%";
                    var size = event.gc.textExtent(text);
                    var offset = cast (Math.max(0, (event.height - size.y) / 2), Int);
                    gc.drawText(text, event.x+2, event.y+offset, true);
                    gc.setForeground(background);
                    gc.setBackground(foreground);
                }
            }
        }));
        for(item in tree.getItems()) {
            item.setExpanded(true);
        }
        shell.pack();
        shell.open();
        while(!shell.isDisposed()) {
            if(!display.readAndDispatch()) display.sleep();
        }
        display.dispose();
    }
}
