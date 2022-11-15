import QtQuick 2.0
import QtQuick.Controls 2.3 as QtControls
import QtQuick.Layouts 1.0 as QtLayouts
import org.kde.kirigami 2.5 as Kirigami

QtLayouts.ColumnLayout {
    id: appearancePage

    property string cfg_displayFormat: "desktopCount"
    property alias cfg_showTotal: showTotal.checked
    property alias cfg_showDesktop: showDesktop.checked
    property alias cfg_filterByActivity: filterByActivity.checked
    property alias cfg_groupingApp: groupingApp.checked

    QtControls.ComboBox {
      id: displayFormat
      Kirigami.FormData.label: i18n("Display format :")
      QtLayouts.Layout.fillWidth: true
      textRole: "label"
      model: [
          {
              'label': i18n("Total count (X)"),
              'name': "totalCount"
          },
          {
              'label': i18n("Desktop count (Y)"),
              'name': "desktopCount"
          }
      ]

      onCurrentIndexChanged: cfg_displayFormat = model[currentIndex]["name"]

      Component.onCompleted: {
            for (var i = 0; i < model.length; i++) {
                if (model[i]["name"] == plasmoid.configuration.displayFormat) {
                    displayFormat.currentIndex = i;
                }
            }
        }

    }

    Item {
      Kirigami.FormData.isSection: true
    }

    Kirigami.FormLayout {
        QtLayouts.Layout.fillWidth: true
        enabled: cfg_displayFormat === "desktopCount"

        QtControls.CheckBox {
            id: showTotal
            text: i18n("Add total count (Y/A)")
            Kirigami.FormData.label: i18n("Option for desktop count display format")
        }

        QtControls.CheckBox {
            id: showDesktop
            text: i18n("Add desktop id (Y~B)")
        }
    }

    Item {
      Kirigami.FormData.isSection: true
    }

    Kirigami.FormLayout {
        QtLayouts.Layout.fillWidth: true

        QtControls.CheckBox {
            id: filterByActivity
            text: i18n("Filter the result by activity")
            Kirigami.FormData.label: i18n("Option for count function :")
        }

        QtControls.CheckBox {
            id: groupingApp
            text: i18n("Tasks are grouped by the application backing them (3 same app give +1 on the total result and not +3)")
        }
    }

    Item {
      Kirigami.FormData.isSection: true
    }

    Item {
        QtLayouts.Layout.fillHeight: true
    }

}
