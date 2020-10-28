package ;

import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.custom.StyleRange;
import org.eclipse.swt.custom.Bullet;
import org.eclipse.swt.custom.ST;
import org.eclipse.swt.graphics.Font;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.graphics.ImageData;
import org.eclipse.swt.graphics.ImageLoader;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.GlyphMetrics;
import org.eclipse.swt.graphics.TextLayout;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.FontDialog;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.widgets.MenuItem;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.ToolBar;
import org.eclipse.swt.widgets.ToolItem;
import org.eclipse.swt.widgets.Widget;
import java.util.Vector;
import ImageHelper;

class TextEditor {
    private var shell: Shell;
    private var toolbar: ToolBar;
    private var text: StyledText;
    private var images = new Images();
    private var vachcedStyled = new Vector();
    private var font: Font;
    private var boldButton: ToolItem;
    private var italicButton: ToolItem;
    private var underlineButton: ToolItem;
    private var strikeThroughButton: ToolItem;
    private var lineNumberWidth: Int;
    private var vcount: Int;

    public function new() {}

    private function addEditItem(menu: Menu, text: String, accelerator: Int, callback: ListenerCallback) {
        var item = new MenuItem(menu, SWT.PUSH);
        item.setText(text);
        item.setAccelerator(accelerator);
        if (callback != null) {
            item.addListener(SWT.Selection, callback);
        }
    }
    private function createEditMenu(): Menu {
        var menu = new Menu(shell, SWT.DROP_DOWN);

        addEditItem(menu, "Cut", SWT.MOD1 + 'X'.code, new ListenerCallback(event -> { text.cut(); }));
        addEditItem(menu, "Copy", SWT.MOD1 + 'C'.code, new ListenerCallback(event -> { text.copy(); }));
        addEditItem(menu, "Paste", SWT.MOD1 + 'V'.code, new ListenerCallback(event -> { text.paste(); }));
        addEditItem(menu, "Select All", SWT.MOD1 + 'A'.code, new ListenerCallback(event -> { text.selectAll(); }));
        return menu;
    }

    private function createFileMenu(): Menu {
        var menu = new Menu (shell, SWT.DROP_DOWN);
        var item = new MenuItem (menu, SWT.PUSH);
        item.setText ("Exit");
        item.setAccelerator(SWT.MOD1);
        item.addListener (SWT.Selection, new ListenerCallback(e ->{ shell.close(); }));

        return menu;
    }
    private function createShell(display: Display): Void {
        shell = new Shell(display);
        shell.setText("Text Editor");
        images.loadAll(display);
        var layout = new GridLayout();
        layout.numColumns = 1;
        layout.marginHeight = 0;
        layout.marginWidth = 0;
        shell.setLayout(layout);
        //TODO: shell dispose listner
    }

    private function createMenuBar() {
        var bar = new Menu(shell, SWT.BAR);
        shell.setMenuBar(bar);

        var fileItem = new MenuItem(bar, SWT.CASCADE);
        fileItem.setText("&File");
        fileItem.setMenu (createFileMenu());

        var editItem = new MenuItem(bar, SWT.CASCADE);
        editItem.setText("Edit");
        editItem.setMenu(createEditMenu());
    }

    private function createStyledText() {
        text = new StyledText(shell, SWT.MULTI | SWT.V_SCROLL | SWT.H_SCROLL);
        text.setFont(new Font(shell.getDisplay(), "Courier", 12, SWT.NONE));
        var spec = new GridData();
        spec.horizontalAlignment = GridData.FILL;
        spec.grabExcessHorizontalSpace = true;
        spec.verticalAlignment = GridData.FILL;
        spec.grabExcessVerticalSpace = true;
        text.setLayoutData(spec);
        text.addLineStyleListener(new LineStyleCallback(event -> {
            event.bulletIndex = text.getLineAtOffset(event.lineOffset);
            var style = new StyleRange();
            lineNumberWidth = (text.getLineCount() + 1 < 100 ? 3 : Std.string(text.getLineCount()+1).length) * 13;
            style.metrics = new GlyphMetrics(0, 0, lineNumberWidth);
            event.bullet = new Bullet(ST.BULLET_CUSTOM, style);
        }));

        text.addPaintObjectListener(new PaintObjectCallback( event -> {
            vcount += 1;
            var bullet = event.bullet;
            var gc = event.gc;
            var paintX = event.x;
            var paintY = event.y;
            var index = event.bulletIndex;
            var lineAscent = event.ascent;
            var lineDescent = event.descent;
            var style = bullet.style;
            var metrics = style.metrics;
            var color = style.foreground;
            if (color != null) gc.setForeground(color);
            var font = style.font;
            if (font != null) gc.setFont(font);
            var string = "";
            // var type = bullet.type & (ST.BULLET_DOT|ST.BULLET_CUSTOM|ST.BULLET_NUMBER|ST.BULLET_LETTER_LOWER|ST.BULLET_LETTER_UPPER);
            // switch (type) {
            //     case ST.BULLET_DOT: string = "\u2022"; break;
            //     case ST.BULLET_CUSTOM: string =         Std.string(index + 1); break;
            //     case ST.BULLET_NUMBER: string =         Std.string(index + 1); break;
            //     case ST.BULLET_LETTER_LOWER: string =   Std.string((index % 26 + 97)); break;
            //     case ST.BULLET_LETTER_UPPER: string =   Std.string((index % 26 + 65)); break;
            // }
            if ((bullet.type & ST.BULLET_CUSTOM) != 0) string =         Std.string( index + 1);
            if ((bullet.type & ST.BULLET_TEXT) != 0) string += bullet.text;

            gc.setBackground(Display.getCurrent().getSystemColor(SWT.COLOR_GRAY));
            gc.fillRectangle(paintX, paintY, metrics.width - 3, text.getLineHeight());

            var display = text.getDisplay();
            var layout = new TextLayout(display);
            layout.setText(string);
            layout.setAscent(lineAscent);
            layout.setDescent(lineDescent);
            // style = (StyleRange)style.clone();
            style = style.clone();
            style.metrics = null;
            if (style.font == null) style.font = text.getFont();
            layout.setStyle(style, 0, string.length);
            var x = paintX + Math.max(0, metrics.width - layout.getBounds().width - 8);
            layout.draw(gc, Std.int(x), paintY);
            layout.dispose();
        }));

        text.addPaintListener(new PaintCallback(event -> {
            var gc = event.gc;
            gc.setBackground(Display.getCurrent().getSystemColor(SWT.COLOR_GRAY));
            gc.fillRectangle(0, vcount * text.getLineHeight(), lineNumberWidth - 6, text.getSize().y);

            gc.setBackground(Display.getCurrent().getSystemColor(SWT.COLOR_RED));
            gc.fillRectangle(lineNumberWidth - 6, 0, 3, text.getSize().y);

            vcount = 0;
            text.redraw();
        }));

        text.addListener(SWT.Modify, new ListenerCallback(event -> {
            shell.redraw(); //Need to redraw shell because text fails to render properly when margin is 0 with Grid
            text.redraw();
        }));
        text.addListener(SWT.KeyDown, new ListenerCallback(event -> {
            // shell.redraw(); //Need to redraw shell because text fails to render properly when margin is 0 with Grid

        }));
    }

    public function open(display: Display) {
        createShell(display);
        createMenuBar();
        createStyledText();
        shell.setSize(500,300);
        shell.open();
        return shell;
    }

    public static function main() {
        var display = new Display();
        var example = new TextEditor();
        var shell = example.open(display);
        while (!shell.isDisposed()) {
            if (!display.readAndDispatch()) {
                display.sleep();
            }
        }

    }

}

class Images {

  // Bitmap Images
    public var Bold: Image;
    public var Italic: Image;
    public var Underline: Image;
    public var Strikeout: Image;
    public var Red: Image;
    public var Green: Image;
    public var Blue: Image;
    public var Erase: Image;

    private var Bitmaps: Array<Image>;
    public function new() {}

    // public function freeAll(): Void {
    //     for(bitmap in Bitmaps) {
    //         bitmap.dispose()
    //     }
    // }


    public function loadAll(display: Display) {
        // ImageHelper.test(display, "images/format-bold.png");
        // Bold =          new Image(display, ImageHelper.load("images/format-bold.png"));
        // Italic =        new Image(display, ImageHelper.load("images/format-italic.png"));
        // Underline =     new Image(display, ImageHelper.load("images/format-underline.png"));
        // Strikeout =     new Image(display, ImageHelper.load("images/format-strikethrough-variant.png"));
        // // // Red =       new Image(display, "red");
        // // // Green =     new Image(display, "green");
        // // // Blue =      new Image(display, "blue");
        // Erase =         new Image(display, ImageHelper.load("images/eraser.png"));

        // Bitmaps = [Bold, Italic, Underline,
        //               Strikeout, Red, Green,
        //               Blue, Erase];
    }
}
