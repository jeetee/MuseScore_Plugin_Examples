import QtQuick 2.0
import QtQuick.Controls 1.1
import MuseScore 1.0
import Qt.labs.settings 1.0

MuseScore {
      menuPath: "Plugins.serializedSettings"
      pluginType: "dialog"
	  version: "1.0"
	  description: "Serializing object into Plugin Settings"

      Settings {
            id: settings
            category: "pluginSettings"
            property string comboBoxList: ""
            }

      onRun: {
            console.log("Loading settings into comboBoxList...");
            var storedList = (settings.comboBoxList)? JSON.parse(settings.comboBoxList) : [{ text: 'Default Item', value: 0 }];
            myDropList.clear();
            myDropList.append(storedList);
            console.log("...Done");

            console.log("Appending into comboBoxList...");
            var newItemValue = storedList[storedList.length - 1].value + 1;
            storedList.push({ text: ("Added Item " + newItemValue), value: newItemValue }); //need this for saving
            myDropList.append(storedList[storedList.length - 1]);
            console.log("...Done");

            console.log("Saving the settings by writing to a settingsProperty...");
            settings.comboBoxList = JSON.stringify(storedList);
            console.log("Done");
            }

      ComboBox {
            id: myDrop
            model: ListModel {
                  id: myDropList
                  //dummy ListElement required for initial creation of this component
                  ListElement { text: "default"; value: 0 }
                  }
            }
      Button {
            y: 30
            text: "Close"
            onClicked: {
                  Qt.quit();
                  }
            }
      }
