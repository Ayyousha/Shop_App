
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';

class ChangeAddressScreen extends StatelessWidget {
  ChangeAddressScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var addressNameController = TextEditingController();
  var addressCityController = TextEditingController();
  var addressRegionController = TextEditingController();
  var addressDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state)
      {
        if(state is updateAddressSuccessState)
        {
          if(state.updateAddressModels.status!){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.updateAddressModels.message!}'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.grey[800],
              ),
            );
          } else
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                action: SnackBarAction(
                  label: '',
                  onPressed: () {},
                ),
                content: Text('${state.updateAddressModels.message!}'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.grey[800],
              ),
            );
          }
        };

      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        if(!cubit.isNewAddress){
        if(cubit.addressModels!.data!.data.length > 0) {
          addressNameController.text = cubit.addressModels!.data!.data[0].name!;
          addressCityController.text = cubit.addressModels!.data!.data[0].city!;
          addressRegionController.text = cubit.addressModels!.data!.data[0].region!;
          addressDetailsController.text = cubit.addressModels!.data!.data[0].details!;
        }
        }
        else if (cubit.deleteAddress)
          {
            addressNameController.clear();
            addressCityController.clear();
            addressRegionController.clear();
            addressDetailsController.clear();
          }

        return Scaffold(
            appBar: _buildAppBar(context),
            backgroundColor: Colors.grey[200],
            body: _buildBody(context),
        );
      },
    );
  }

  /// App Bar
  PreferredSizeWidget _buildAppBar(context) => AppBar(
    elevation: 5,
    backgroundColor: HexColor('1a2f3f'),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: HexColor('1a2f3f'),
    ),
    title: Text(
      'Address',
      style: TextStyle(color: Colors.white),
    ),
    titleSpacing: 0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      splashRadius: 23,
      icon: Icon(
        Icons.arrow_back_outlined,
        color: Colors.white,
      ),
    ),

  );

  /// Body
  Widget _buildBody(context) {
    var cubit = HomeCubit.get(context);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSizedBox(30),
              /// Name
              _buildName(),
              heightSizedBox(5),
              _buildNameTextField(),
              heightSizedBox(12),
              /// City
              _buildCity(),
              heightSizedBox(5),
              _buildCityTextField(),
              heightSizedBox(12),
              /// Region
              _buildRegion(),
              heightSizedBox(5),
              _buildRegionTextField(),
              heightSizedBox(12),
              /// Phone
              _buildDetails(),
              heightSizedBox(5),
              _buildDetailsTextField(),
              heightSizedBox(30),
              if(cubit.isNewAddress)
                _buildAddButton(context),
              if(cubit.isNewAddress == false)
                _buildUpdateButton(context),
              heightSizedBox(5),
              if(cubit.isNewAddress == false)
                _buildDeleteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Name && NameTextField
  Widget _buildName() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              );
  Widget _buildNameTextField() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        prefixIcon: Icon(ShopIcon.map_marker, color: HexColor('1a2f3f')),
        hintText: " Address name",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: HexColor('1a2f3f').withOpacity(0.1),
      ),
      controller: addressNameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Address name is Empty';
        }
        return null;
      },
    ),
  );

  /// City && CityTextField
  Widget _buildCity() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'City',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              );
  Widget _buildCityTextField() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        prefixIcon: Icon(ShopIcon.apartment, color :HexColor('1a2f3f')),
        hintText: " City",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: HexColor('1a2f3f').withOpacity(0.1),
      ),
      controller: addressCityController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'City is Empty';
        }
        return null;
      },
    ),
  );

  /// Region && RegionTextField
  Widget _buildRegion() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Region',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              );
  Widget _buildRegionTextField() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        prefixIcon: Icon(ShopIcon.map, color: HexColor('1a2f3f')),
        hintText: " Region",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: HexColor('1a2f3f').withOpacity(0.1),
      ),
      controller: addressRegionController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Region is Empty';
        }
        return null;
      },
    ),
  );

  /// Details && DetailsTextField
  Widget _buildDetails() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              );
  Widget _buildDetailsTextField() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        prefixIcon: Icon(ShopIcon.warning, color: HexColor('1a2f3f')),
        hintText: " Details",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: HexColor('1a2f3f').withOpacity(0.1),
      ),
      controller: addressDetailsController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Details is Empty';
        }
        return null;
      },
    ),
  );

  /// Add Button
  Widget _buildAddButton(context) {
    var cubit = HomeCubit.get(context);
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: defaultCircularButton(
                    height: 40,
                    function: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                        cubit.addAddresses(
                          name: addressNameController.text,
                          city: addressCityController.text,
                          region: addressRegionController.text,
                          details: addressDetailsController.text,
                        );
                        cubit.getAddresses();
                      }
                    },
                    text: 'Add Address',
                    FontWeight: FontWeight.w900,
                    // background: Colors.amber[700]!,
                    isCapital: false,
                    LinearGradient: LinearGradient(
                      colors: [HexColor('1a2f3f'),HexColor('1a2f3f')],
                    ),
                    rounderRadius: 5,
                  ),
                );
  }

  /// Update Button
  Widget _buildUpdateButton(context) {
    var cubit = HomeCubit.get(context);
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: defaultCircularButton(
                    height: 40,
                    function: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                        cubit.updateAddresses(
                          name: addressNameController.text,
                          city: addressCityController.text,
                          region: addressRegionController.text,
                          details: addressDetailsController.text,
                        );
                        cubit.getAddresses();
                      }
                    },
                    text: 'Update Address',
                    FontWeight: FontWeight.w900,
                    // background: Colors.amber[700]!,
                    isCapital: false,
                    LinearGradient: LinearGradient(
                      colors: [HexColor('1a2f3f'),HexColor('1a2f3f')],
                    ),
                    rounderRadius: 5,
                  ),
                );
  }

  /// Delete Button
  Widget _buildDeleteButton(context) {
    var cubit = HomeCubit.get(context);
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: defaultButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          ShopIcon.trash,
                          color: Colors.white,
                          size: 15,
                        ),
                        widthSizedBox(5),
                        Text(
                          'Remove Address',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    height: 40,
                    function: ()
                    {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Removing Address !!!'),
                          content: const Text('Are you sure to delete your Address'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                              style:  TextButton.styleFrom(
                                  backgroundColor: Colors.green[700]
                              ),
                            ),
                            TextButton(
                              onPressed: ()
                              {
                                cubit.deleteAddresses();
                                Navigator.pop(context, 'OK');


                              },
                              child: const Text('OK',style: TextStyle(color: Colors.white),),
                              style:  TextButton.styleFrom(
                                  backgroundColor: Colors.redAccent[700]
                              ),
                            ),
                          ],
                        ),
                      );

                    },
                    background: Colors.red,
                    isCapital: false,
                  ),
                );
  }

}