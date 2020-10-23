package ;

import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swtchart.Chart;
import org.eclipse.swtchart.ILineSeries;
import org.eclipse.swtchart.ISeries;
import java.NativeArray;

/**
 * An example for line chart.
 */
class LineChartExample {

	private static var ySeries = NativeArray.make(0.0, 0.38, 0.71, 0.92, 1.0, 0.92, 0.71, 0.38, 0.0, -0.38, -0.71, -0.92, -1.0, -0.92, -0.71, -0.38);

	/**
	 * The main method.
	 *
	 * @param args
	 *            the arguments
	 */
	public static function main() {

		var display = new Display();
		var shell = new Shell(display);
		shell.setText("Line Chart");
		shell.setSize(500, 400);
		shell.setLayout(new FillLayout());
		createChart(shell);
		shell.open();
		while(!shell.isDisposed()) {
			if(!display.readAndDispatch()) {
				display.sleep();
			}
		}
		display.dispose();
	}

	/**
	 * create the chart.
	 *
	 * @param parent
	 *            The parent composite
	 * @return The created chart
	 */
	public static function createChart(parent: Composite) {

		// create a chart
		var chart = new Chart(parent, SWT.NONE);
		// set titles
		chart.getTitle().setText("Line Chart");
		chart.getAxisSet().getXAxis(0).getTitle().setText("Data Points");
		chart.getAxisSet().getYAxis(0).getTitle().setText("Amplitude");
		// create line series
		var lineSeries = chart.getSeriesSet().createSeries(ISeries_SeriesType.LINE, "line series");
		lineSeries.setYSeries(ySeries);
		// adjust the axis range
		chart.getAxisSet().adjustRange();
		return chart;
	}
}
