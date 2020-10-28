import org.eclipse.swt.*;
import org.eclipse.swt.events.*;
import org.eclipse.swt.graphics.*;
import org.eclipse.swt.layout.*;
import org.eclipse.swt.widgets.*;
import callbacks.*;

 class Snippet77 {

public static function main() {
	var display = new Display();
	var shell = new Shell(display);
	shell.setText("Snippet 77");
	shell.setLayout(new FillLayout());

	final comp = new Composite(shell, SWT.NONE);
	final table = new Table(comp, SWT.BORDER | SWT.V_SCROLL);
	table.setHeaderVisible(true);
	table.setLinesVisible(true);
	final column1 = new TableColumn(table, SWT.NONE);
	column1.setText("Column 1");
	final column2 = new TableColumn(table, SWT.NONE);
	column2.setText("Column 2");
	for (i in 0...10) {
		var item = new TableItem(table, SWT.NONE);
		item.setText(java.NativeArray.make("item 0" + i, "item 1"+i));
	}
	comp.addControlListener(new ControlCallback(
        { 
            controlResized: (e) -> {
                var area = comp.getClientArea();
                var size = table.computeSize(SWT.DEFAULT, SWT.DEFAULT);
                var vBar = table.getVerticalBar();
                var width = area.width - table.computeTrim(0, 0, 0, 0).width - vBar.getSize().x;
                if (size.y > area.height + table.getHeaderHeight()) {
                    // Subtract the scrollbar width from the total column width
                    // if a vertical scrollbar will be required
                    var vBarSize = vBar.getSize();
                    width -= vBarSize.x;
                }
                var oldSize = table.getSize();
                if (oldSize.x > area.width) {
                    // table is getting smaller so make the columns
                    // smaller first and then resize the table to
                    // match the client area width
                    column1.setWidth(Std.int(width / 3));
                    column2.setWidth(width - column1.getWidth());
                    table.setSize(area.width, area.height);
                } else {
                    // table is getting bigger so make the table
                    // bigger first and then make the columns wider
                    // to match the client area width
                    table.setSize(area.width, area.height);
                    column1.setWidth(Std.int(width / 3));
                    column2.setWidth(width - column1.getWidth());
                }
            }
        }
    ));

	shell.open();
	while (!shell.isDisposed()) {
		if (!display.readAndDispatch())
			display.sleep();
	}
	display.dispose();
}
}
