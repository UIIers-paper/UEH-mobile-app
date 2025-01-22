import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/widgets/text_field.dart';

class AccountLinkingContent extends StatelessWidget {
  final TextEditingController microsoftEmailController;
  final TextEditingController googleEmailController;
  final TextEditingController phoneController = TextEditingController();
  final AuthService _authService = AuthService();
  AccountLinkingContent({
    Key? key,
    required this.microsoftEmailController,
    required this.googleEmailController,
  }) : super(key: key);


  void _checkAndHandleEmptyFields({
    required BuildContext context,
    required Map<String, TextEditingController> fields,
    required VoidCallback onAllFieldsValid,
  }) {
    bool hasEmptyField = false;
    fields.forEach((fieldName, controller) {
      if (controller.text.isEmpty) {
        hasEmptyField = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter $fieldName.")),
        );
      }
    });

    if (!hasEmptyField) {
      onAllFieldsValid();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        margin: EdgeInsets.all(16),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(FontAwesomeIcons.link, size: 28, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    "Link Your Accounts",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFieldWidget(
                controller: microsoftEmailController,
                labelText: "Microsoft Account Email",
                icon: FontAwesomeIcons.microsoft,
                color: Colors.blueAccent,
                onButtonPressed: () async {
                  _checkAndHandleEmptyFields(
                    context: context,
                    fields: {
                      "Microsoft account email": microsoftEmailController,
                    },
                    onAllFieldsValid: () async {
                      try {
                        await _authService.linkMicrosoftAccount(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Microsoft account linked successfully!")),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to link Microsoft account: $e")),
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 15),
              TextFieldWidget(
                controller: googleEmailController,
                labelText: "Google Account Email",
                icon: FontAwesomeIcons.google,
                color: Colors.redAccent,
                onButtonPressed: () async{
                  _checkAndHandleEmptyFields(
                    context: context,
                    fields: {
                      "Google account email": googleEmailController,
                    },
                    onAllFieldsValid: () async {
                      try {
                        await _authService.linkGoogleAccount(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Google account linked successfully!")),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to link Google account: $e")),
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 15),
              TextFieldWidget(
                controller: phoneController,
                labelText: "Phone Number",
                icon: FontAwesomeIcons.phone,
                color: Colors.green,
                keyboardType: TextInputType.phone,
                onButtonPressed: () {
                  _checkAndHandleEmptyFields(
                    context: context,
                    fields: {
                      "Phone number": phoneController,
                    },
                    onAllFieldsValid: () {
                      final phoneNumber = phoneController.text;
                      _authService.linkPhoneAccount(
                        phoneNumber: phoneNumber,
                        onCodeSent: (verificationId) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Verification code sent to $phoneNumber")),
                          );
                        },
                        context: context,
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final microsoftEmail = microsoftEmailController.text;
                    final googleEmail = googleEmailController.text;
                    final phoneNumber = phoneController.text;

                    if (microsoftEmail.isNotEmpty ||
                        googleEmail.isNotEmpty ||
                        phoneNumber.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Saving accounts for Microsoft: $microsoftEmail, Google: $googleEmail, Phone: $phoneNumber"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(
                            "Please fill at least one account detail.")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FontAwesomeIcons.save, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
