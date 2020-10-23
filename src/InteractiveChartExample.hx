package ;

import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swtchart.Chart;
import org.eclipse.swtchart.IBarSeries;
import org.eclipse.swtchart.ILineSeries;
import org.eclipse.swtchart.ISeries_SeriesType;
import org.eclipse.swtchart.extensions.charts.InteractiveChart;
import org.eclipse.ui.part.ViewPart;
import java.NativeArray;

/**
 * An example view to show InteractiveChart.
 */
class InteractiveChartExample extends ViewPart {

	private static final categorySeries = NativeArray.make("Mon", "Tue", "Wed", "Thu", "Fri");
    private static final yLineSeries1 =   NativeArray.make(4.6, 5.4, 6.9, 5.6, 7.1);
    private static final yLineSeries2 =   NativeArray.make(6.0, 5.1, 4.9, 5.3, 4.2);
    private static final yBarSeries1 =    NativeArray.make(1.1, 2.9, 3.3, 4.4, 3.5);
    private static final yBarSeries2 =    NativeArray.make(4.3, 3.4, 2.8, 2.1, 1.9);

	/** the chart */
	private var chart: Chart;

	@Override
	public function createPartControl(parent: Composite) {

		parent.setLayout(new FillLayout());
		// create an interactive chart
		chart = new InteractiveChart(parent, SWT.NONE);
		// set title
		chart.getTitle().setText("Sample Interactive Chart");
		// set category series
		chart.getAxisSet().getXAxis(0).enableCategory(true);
		chart.getAxisSet().getXAxis(0).setCategorySeries(categorySeries);
		// create line series 1
		var lineSeries1 = chart.getSeriesSet().createSeries(SeriesType.LINE, "line series 1");
		lineSeries1.setYSeries(yLineSeries1);
		// create line series 2
		var lineSeries2 = chart.getSeriesSet().createSeries(SeriesType.LINE, "line series 2");
		lineSeries2.setYSeries(yLineSeries2);
		lineSeries2.setLineColor(Display.getDefault().getSystemColor(SWT.COLOR_RED));
		// create bar series 1
		var barSeries1 = chart.getSeriesSet().createSeries(SeriesType.BAR, "bar series 1");
		barSeries1.setYSeries(yBarSeries1);
		// create bar series 2
		var barSeries2 = chart.getSeriesSet().createSeries(SeriesType.BAR, "bar series 2");
		barSeries2.setYSeries(yBarSeries2);
		barSeries2.setBarColor(Display.getDefault().getSystemColor(SWT.COLOR_GREEN));
		// adjust the axis range
		chart.getAxisSet().adjustRange();
	}

	@Override
	public function setFocus() {

		chart.setFocus();
	}

	@Override
	public function dispose() {

		super.dispose();
		chart.dispose();
	}
}
