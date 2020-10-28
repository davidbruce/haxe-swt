import org.eclipse.swt.*;
import org.eclipse.swt.layout.*;
import org.eclipse.swt.widgets.*;

class Snippet38 {
    public static function main() {
        var display = new Display();
        var shell = new Shell(display);
        shell.setText("Snippet 38");
        shell.setLayout(new GridLayout());
        var table = new Table(shell, SWT.MULTI | SWT.BORDER | SWT.FULL_SELECTION);
        table.setLinesVisible(true);
        table.setHeaderVisible(true);
    
        var titles = [" ", "C", "!", "Description", "Resource", "In Folder", "Location"];
        for (title in titles) {
            var column = new TableColumn(table, SWT.NONE);
            column.setText(title);
        }
        var count = 128;
        for (i in 0...count) {
            var item = new TableItem(table, SWT.NONE);
            item.setText(0, "x");
            item.setText(1, "y");
            item.setText(2, "!");
            item.setText(3, "this stuff behaves the way I expect");
            item.setText(4, "almost everywhere");
            item.setText(5, "some.folder");
            item.setText(6, "line " + i + " in nowhere");
        }
        for (i in 0...titles.length) {
            table.getColumn(i).pack();
        }
        table.setSize(table.computeSize(SWT.DEFAULT, 200));
        shell.pack();
        shell.open();
        while (!shell.isDisposed()) {
            if (!display.readAndDispatch())
                display.sleep();
            }
        display.dispose();
    }
}