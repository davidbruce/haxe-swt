package ;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swtchart.IAxis;
import org.eclipse.swtchart.LineStyle;
import org.eclipse.swtchart.extensions.axisconverter.MillisecondsToMinuteConverter;
import org.eclipse.swtchart.extensions.axisconverter.PercentageConverter;
import org.eclipse.swtchart.extensions.core.IChartSettings;
import org.eclipse.swtchart.extensions.core.IPrimaryAxisSettings;
import org.eclipse.swtchart.extensions.core.ISecondaryAxisSettings;
import org.eclipse.swtchart.extensions.core.ISeriesData;
import org.eclipse.swtchart.extensions.core.SecondaryAxisSettings;
// import org.eclipse.swtchart.extensions.examples.support.SeriesConverter;
import org.eclipse.swtchart.extensions.linecharts.ILineSeriesData;
import org.eclipse.swtchart.extensions.linecharts.LineSeriesSettings;
import org.eclipse.swtchart.extensions.linecharts.LineChart;
import org.eclipse.swtchart.extensions.linecharts.LineSeriesData;

class CustomLineChart extends LineChart {

	private static final LENGTH_HINT_DATA_POINTS = 15000;
	//
	private var enableRangeSelector: Bool;
	private var showAxisTitle: Bool;
	private var enableHorizontalSlider: Bool;
	private var seriesXY: String;

	public function new(parent: Composite, style: Int, enableRangeSelector: Bool, showAxisTitle: Bool, enableHorizontalSlider: Bool, seriesXY: String) {

		super(parent, style);
		this.enableRangeSelector = enableRangeSelector;
		this.showAxisTitle = showAxisTitle;
		this.enableHorizontalSlider = enableHorizontalSlider;
		this.seriesXY = seriesXY;
		createControl();
	}

	private function createControl() {

		configureChart();
		addDemoSeries();
	}

	private function configureChart() {

		try {
			var chartSettings = getChartSettings();
			chartSettings.setOrientation(SWT.HORIZONTAL);
			chartSettings.setEnableRangeSelector(enableRangeSelector);
			chartSettings.setHorizontalSliderVisible(enableHorizontalSlider);
			chartSettings.setVerticalSliderVisible(enableHorizontalSlider);
			chartSettings.getRangeRestriction().setZeroX(true);
			chartSettings.getRangeRestriction().setZeroY(true);
			//
			var primaryAxisSettingsX = chartSettings.getPrimaryAxisSettingsX();
			primaryAxisSettingsX.setTitle("Time [ms]");
			primaryAxisSettingsX.setDecimalFormat(new DecimalFormat(("0.0##"), new DecimalFormatSymbols(Locale.ENGLISH)));
			primaryAxisSettingsX.setColor(getDisplay().getSystemColor(SWT.COLOR_BLACK));
			primaryAxisSettingsX.setPosition(IAxis_Position.Secondary);
			primaryAxisSettingsX.setVisible(false);
			primaryAxisSettingsX.setGridLineStyle(LineStyle.NONE);
			//
			var primaryAxisSettingsY = chartSettings.getPrimaryAxisSettingsY();
			primaryAxisSettingsY.setTitle("Intensity [counts]");
			primaryAxisSettingsY.setDecimalFormat(new DecimalFormat(("0.0#E0"), new DecimalFormatSymbols(Locale.ENGLISH)));
			primaryAxisSettingsY.setColor(getDisplay().getSystemColor(SWT.COLOR_BLACK));
			primaryAxisSettingsY.setPosition(IAxis_Position.Primary);
			primaryAxisSettingsY.setVisible(true);
			primaryAxisSettingsY.setGridLineStyle(LineStyle.NONE);
			/*
			 * Secondary X-Axes
			 */
			var axisTitle = (showAxisTitle) ? "Minutes" : "";
			var secondaryAxisSettingsX1 = new SecondaryAxisSettings(axisTitle, "Time [min]", new MillisecondsToMinuteConverter());
			secondaryAxisSettingsX1.setPosition(IAxis_Position.Primary);
			secondaryAxisSettingsX1.setDecimalFormat(new DecimalFormat(("0.00"), new DecimalFormatSymbols(Locale.ENGLISH)));
			secondaryAxisSettingsX1.setColor(getDisplay().getSystemColor(SWT.COLOR_BLACK));
			chartSettings.getSecondaryAxisSettingsListX().add(secondaryAxisSettingsX1);
			/*
			 * Secondary Y-Axes
			 */
			var secondaryAxisSettingsY1 = new SecondaryAxisSettings("Intensity [%]", new PercentageConverter(SWT.VERTICAL, true));
			secondaryAxisSettingsY1.setPosition(IAxis_Position.Secondary);
			secondaryAxisSettingsY1.setDecimalFormat(new DecimalFormat(("0.00"), new DecimalFormatSymbols(Locale.ENGLISH)));
			secondaryAxisSettingsY1.setColor(getDisplay().getSystemColor(SWT.COLOR_BLACK));
			chartSettings.getSecondaryAxisSettingsListY().add(secondaryAxisSettingsY1);
			//
			applySettings(chartSettings);
		} catch(e) {
			trace(e);
		}
	}

	private function addDemoSeries() {

		var lineSeriesDataList = new ArrayList<ILineSeriesData>();
		// var seriesData = SeriesConverter.getSeriesXY(seriesXY);

        // var lineSeriesData = new LineSeriesData(seriesData);
		// var lineSeriesSettings  = cast (lineSeriesData.getSettings(), LineSeriesSettings);
		// lineSeriesSettings.setEnableArea(true);
		// var lineSeriesSettingsHighlight = cast (lineSeriesSettings.getSeriesSettingsHighlight(), LineSeriesSettings);
		// lineSeriesSettingsHighlight.setLineWidth(2);
		// lineSeriesDataList.add(lineSeriesData);
		// /*
		//  * Set series.
		//  */
		// addSeriesData(lineSeriesDataList, LENGTH_HINT_DATA_POINTS);
	}
}
