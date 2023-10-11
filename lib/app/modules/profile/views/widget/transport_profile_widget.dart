import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/modules/profile/views/widget/tranport_widget.dart';


class TransportProfileWidget extends StatelessWidget {


  const TransportProfileWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return  const Column(
      children: [
        TransportWidget(title: AppText.transportRoute, value: 'Transport Route 97',),
        TransportWidget(title: AppText.transportVehicleNo, value: 'Turner Bergnaum',),
        TransportWidget(title: AppText.transportDriverName, value: 'Turner Bergnaum',),
        TransportWidget(title: AppText.transportDriverPhoneNo, value: '1234578',),
        TransportWidget(title: AppText.transportDriverName, value: '1234578',),
        TransportWidget(title: AppText.transportDormitory, value: 'Sir Isaac Newton Hostel',),
      ],
    );
  }
}




