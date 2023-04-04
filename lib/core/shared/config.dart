import 'package:parking_app/features/profile/domain/user.dart';
import 'package:provider/provider.dart';

import '../../features/profile/application/user_provider.dart';

const url = 'http://10.0.2.2:3000';

const registration = "$url/registration";
const login = '$url/login';
const registerVehicleUrl = '$url/createVehicleDetail';
const getTempleList = '$url/getTempleList';
const getSchoolList = '$url/getSchoolList';
const getMallList = '$url/getMallList';
const getTrekList = '$url/getTrekList';
const uploadProfile = '$url/uploadProfile';
const setReservation = '$url/reservation';
const getVehicleData = '$url/getVehicleData';
const createKYC = '$url/createKycDetail';
const getKycDetails = '$url/getKYC';
