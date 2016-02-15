import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.2
import MuseScore 1.0
import Qt.labs.settings 1.0

MuseScore {
      menuPath: "Plugins.serializedSettings"
      //pluginType: "dialog" //Doesn't allow live editing of comboBox list when ran from Menu
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

            console.log("Showing the resulting plugin dialog:");
            pluginDialog.open();
            }

      Dialog {
            id: pluginDialog
            standardButtons: StandardButton.NoButton

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
                        console.log("clicked");
                        pluginDialog.close();
                        Qt.quit();
                        }
                  }
            }
      }
