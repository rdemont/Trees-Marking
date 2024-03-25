


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:treesmarking/businessObj/campaign.dart';


class CampaignWidget extends StatefulWidget {

  final List<Campaign> campaignList;
  int? selectedCampaignId;
  Function onCamaignChange; 

  CampaignWidget(
  {
    super.key,
    required this.campaignList,
    //required this.selectedCampaignId,
    required this.onCamaignChange
  });


  @override
  State<CampaignWidget> createState() => _CampaignWidgetState();

}





class _CampaignWidgetState extends State<CampaignWidget> {
  final TextEditingController groupItemController = TextEditingController();
  Offset _tapPosition = Offset.zero;

  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void showContextMenu(BuildContext context, int taskId) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();

    showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),
        items: [
          PopupMenuItem(
            value: "delete",
            child: const Text("Delete"),
            onTap: () {}
            ,
          ),
          const PopupMenuItem(
            value: "rename",
            child: Text("Rename"),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Wrap(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 40, left: 20),
            child: const Text(
              "Campaign :",
              style: TextStyle(fontSize: 30),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: widget.campaignList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTapDown: (details) => _getTapPosition(details),
                onLongPress: () {
                  showContextMenu(context, widget.campaignList[index].id!);
                },
                child: ListTile(
                  title: Text(widget.campaignList[index].name+"/"+DateFormat("dd.MM.yyyy").format(widget.campaignList[index].campaignDate)),
                  selected:
                      widget.selectedCampaignId == widget.campaignList[index].id,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      widget.selectedCampaignId = widget.campaignList[index].id;
                      //widget.onListChange;
                      widget.onCamaignChange(widget.campaignList[index].id);
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: () {
          addCampaign();
        },
      ),
    );
  }

  addCampaign() {
    var textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New campaign"),
        content: TextField(
          controller: textFieldController,
          decoration: const InputDecoration(hintText: "Campaign name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
debugPrint("Test Debug Pring");
print(textFieldController.text);
              Campaign campaign = Campaign.newObj();
              campaign.name = textFieldController.text;
print("Campaign Save 1");
              campaign.save().then((value){
                int tmpid = campaign.id ;
print("Campaign Save DONE with Value $value and ID: $tmpid");              
                widget.onCamaignChange(campaign.id);
              });

              
              

              Navigator.pop(context, 'OK');
              
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

