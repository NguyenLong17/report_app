import 'package:flutter/material.dart';
import 'package:report_app/common/const/const.dart';
import 'package:report_app/common/hive_manager.dart';
import 'package:report_app/common/util/navigator.dart';
import 'package:report_app/common/widgets/confirm_dialog.dart';
import 'package:report_app/common/widgets/progress_dialog.dart';
import 'package:report_app/common/widgets/toast_overlay.dart';
import 'package:report_app/page/account/account_page.dart';
import 'package:report_app/page/account/change_password_page.dart';
import 'package:report_app/page/account/login_page.dart';
import 'package:report_app/page/issue_page.dart';
import 'package:report_app/page/report_page.dart';
import 'package:report_app/service/api_service.dart';
import 'package:report_app/service/user_service.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  late ProgressDialog progress;
  var url = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAilBMVEX///8BAAIAAABhYWHPz88wMDBdXV3c3NylpaWWlpaGhoZLS0u0tLTu7u78/Pz29vbFxcUbGxwnJyjl5eXMzMzi4uJmZmZ5eXmKioo5ODk/P0A0NDWcnJzW1ta6urpTU1NwcHAjIyMQEBBHR0gNDA6tra2ioqIZGBlXV1d9fX5zc3QfHiCRkZHAv8Cf/mBsAAALCElEQVR4nO2dZ3vyOgyGg1gtI2EUyix0pJS+9P//vRNGC7IdW3Y8wrnyfGyT2HciD9myiGqBBct+5FahCWswcowYGjBDbLpFDM1Xc/4VQ+MdBUOXiKHpTnJqqKHhznKJGJrtInh1hhga7VfwzxViaLI/OTPU0GBXuUIMzXUjR4MGU4h7yRCdDP2+AeWILgwVl2D/+aweZIROvmJYQg7XQVsMSiiwWfuGGpZwNnePGJZwFQkQLc9uwhI+RsnCNWJowihZOjbU4IRR0uQRbQ4a4QmFhmpx0CgBoRDR3lcsA6HQUK21xVIQCrsbW15/OQiFhrqzg1gSwihxNrspC2GUjBwhloZQ+BVtDBrlIRS2RQvdTYkIHU3gykToZgJXKkIng0a5CF1M4EpG6GDQKBuhcNAo1KOWjtC6M1U+QtsTuBISCtti3bjEMhIKDPVuCVc5V8Ub+J8QNrtibdimeK+Eks2u/4mV0lURSlQR2lZFWBHqqyK0rYqwItSXf0KjyKI7Ivw0C566I8J+m6hJD+6TkK5GRUhURRhOFSFVFWE4VYRUVYThVBFSVRGGU0VIVUUYThUhVRVhOFWEVFWE4VQRUlURhlNFSFVFSFIy6+Tr0/ChpSLsSveQZmYPLRMhG2aHBdAxemp5COOuYlvXELE0hErAI6KJoZaGUA1oiFgSwngjTeVxRdQ31HIQZiZKi60wQCwFIaENXhF1DbUUhHRAA8QSEJJN9BdRz1DDE2oCaiOGJ9Qx0V9EHUMNTiifquUhanxFv4TxOl093mr1bhSBB7BlnvPTj3OKHCDCVpxznQ3C5KeuPhBBZ2TVnLUZtvHP7PudDWyD5XaWtg0OeKkJe6MCQDTk1vivtEk6nQvf4flv/75Wa8uE/Y1LvL/KP5wKWx9Gcvs4Y9Z/LBJO3POdaz6LxiuasZwgnxvkZolv5r7gPx98p2p3ddrCsfl+JjYIW54Aa6LUbarr32YkRnwb88+BFxM11MlYCX0rvon5J3/muFzKGFfK9ojvwP8bl/kTnpW1x5cChL3SA54+Y1duqvhy/L/nOyA8MfZMCfW9hzACmEp6VXwp/h9/8l9dVuGJq+hRqgcCDJ+MCPlsMepKvc1bndX+q1krAnlBmm+mz4fPx8629f6moARI3RNm5X+l1yn0+nFhxHgCWTz3nsaoLsl68Pg1zIfMdz1tEWZFH9g+rb3VZsxueH1+GUdi9deHXEcgm5CLh0ZLhAB7UZ/dpi0YX/FgOlAM4ePDhxgy+/LC/sYKYdb82qKHZ0rJiMfPl5I8hkZLyJiN/iJEG4TSQbfBJ3zOechcOqwh5dg/LAVvyArhVlabPp+LRcQ3/NFaiBlPRYwiQ7VACO+KyigNNavsTHuh6elVkCtbUJfihDBSuWkNBSLAJq/3lOpRhLi1TgiQ18lcpUg1n5umRqX2kk+Cwj2sKCHk5QlCksz/AHa6q2dXxd8CRGadqjDhB6UB5dspQMt0qfekngBxYpcwdz6INM2dbO2L8EWilwcL9M4KEkLNtB4XQIqNy9XecYgHm4TErZZYOChKPIJsHE17NxpILmQRcedXjBAg3y/D6ginWTITf0LO4UZyZf+VRXy9sdOChDvisqzITAFbE3/H7bUt2aWTD2CefGNaBQmnRMAoFvR5z9I7NAijNZtk4qY/LUhI7wl5QnmltQi5teubV1+QkN4Vcjnm3hTjoBZhNGO3GxuWCOkOz5a1o4biBj1Cdtcd5pYIVdW8asS8Y+VcVJOwz37E37XwgoSqJfU//TAVkPX+RoRcCQs7hGSvYMG84YnyDl1Cxk7/huqChNS+9Il5wYTAGm1CxtP+7U4LEm6JhLifgSHBn9AmzDxiVAiMbRA2aa4P7gaA1Hz1CZnJ78XAChICzXtd4aLnNJ9Sl/CYZgtVzgJhTT61FD9JPuEuQhjj+em5rylKOKKUPMHv9pVyjwkhayvfFghrIHHc/sR0AbRlARPCmDHT2AZhk1Bwky/XDSHetobT6y9MSPgieKCielxGhNgNPflnRQkpOe9fbosFkl2bEsboZ05OM7fChDXoqord4n6GuHpoRIib/GnQL0546bLyhdPkKzz7ooRtzl5sEMr94Pgdtw2qO2JGyLzOjq39w+98y+s3gTMch4RRHd3WtbYH3M1bc2sMGd97kXOhLcIUm2lsbR9/Jxw04g4XzExthqaETENMLMZijLjY5PiB36elr+wYEuJFPWjYi6fJYEaz9dVYk/VeEP1CXyQ3Pm+Bu5qe7Zio0fT50Ht6SfetYU68BOpo+k+NXOFfwuiu86/Ey2G4q1k5jGvL2WxCJaR89FrO/bILd+iZyL/IxmoZodm5GPkrmKMSrESwMpP/HtN+8bWYcOuAcJNfG+NnYkJ8muhdSpg6IMSOhQtC3EPNpYTsjo6N2uDh0AVhGxGO5LH69s+TMOs6Lgj7iHAnJ7RvpoDzgLggTBBhTXFmhv/ZzKK1wW6I+2/4oSBs226JTGSDC8IJIvynOrtm+1wQsw3ggnAN+H/4Wo4waggiAIvUBs+g3Y+HC/UZ0qMDZA+SiY50QfiDCDeUc8D9w6tsVqgUKgHPIXtW5qV43R3P2Ke0s9xxO91P64ZCZxiPLumtRX3l34c2POFVUv4WVXaP7jt4yPUVY6ebHGqJewy6f4h2myH1QbhEhMT1YHMfH0XOZ8W5J2QWhMkROIaEzGbs2AfhDBX5Rb3NkHCgsxJlSdglJf+0ryFhBw/48tVES2qbdTWGhLij+faSNxFHuBL3xU0JmZ28Bz+ZIb+YWQZNZoTMTl7bDyFe/aJuXJgR4rXE42EXH4R4NYRqpkaEzFhxvMsHYYSCQDKnlCQjwk9sLseUKV4IcXoNYm9qRNjkG4QXwhdMSKutCSEOEDzv5HkhZPaDCGfBIjNCnEHgHCbihxBnZ6BFNBoQMrEmcJo++SFcG+x0GxDW8Ys8B4n4IWRDhClBQ/qETCu8HNPzRMiE1FH2SfUJ8W7gb+yrJ0I2kp4Q0qhNiMbC85z0KE+E2EkkHYzVJWRf4ttlRcgXYcIeh1AG6+sS1plP+Lu67ouQPZ6njoTWJPxkX+Gvp+2NsM8ugKoCa/QIudNrf/N7b4T82StFZI0WIRPhfXtuzB9hwhyUVZ3t0iLsss++vj5/hOzBJNX8VIdwyj76JnrOIyGXoxB2snW3BtqbkBLuuXd3Yx4+CRN2DwuGkmPEjV3zqtFW8twZ99zbZQSfhMyZlmOBI/UZNqW4Y+KwvP23V0I+tQK8mSfFuGjLZ6tF7dsvYcKenNcJVhSK/+kCYOI9/BIKQh8Up/IVWr/xgFt8iWdCQWYsgC+DDM9nfXJP48OsfRNGoowyNfKmIlJSFyVqYF+Xd0JudD5Vq2WQRkkQYy3a+PFPKMpXD5RksliNuSjXF5tgKApCGItijwGaDxqMa4EliAGD/CpZNgcXVu+N+vNeDXH2RPH54hCEUfIuriDAXp2JvP+wFPLlHaAOQhjFgl7wArl8bEsmq+OXOhdM9HevOBl9GMLjKrg44OsU4zRNRX5Vf9BZ5OEdh5wcXywUoShh3g1k1vFMVy+DxqQfJ+P100/aef8QxILd3LPImzaIHu5JOYCSekiuz19FlxRzP5IeRg5dOQsCmMu8zNDVKyxQOSehK1hUABuFDx26hoWUfb+h8lhx6EoWECgN9L4JM7zdIyXjX+iKGgqOvggto2HoqhroNPjXyamjQ1dXVye8RUpNSHlfhOeZW3Pa01tFDl1tqs7f7vthop11OHTNiYJ5Osj7lT25/gNRxrCDEHAQ9QAAAABJRU5ErkJggg==';

   String? userName;
   String? phoneNumber;

  @override
  void initState() {
    progress = ProgressDialog(context);
    // getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if(apiService.user?.avatar != null)...{
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: GestureDetector(
                onTap: () {
                  navigatorPush(context, AccountPage());
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(),
                        child: Image.network(
                          apiService.user?.avatar! ?? baseAddImageNetwork,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            apiService.user?.name ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            apiService.user?.phoneNumber ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          }else...{
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: GestureDetector(
                onTap: () {
                  navigatorPush(context, AccountPage());
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(),
                        child: Image.asset(
                          'assets/images/add.PNG',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            apiService.user?.name ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            apiService.user?.phoneNumber ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          },
          ListTile(
            leading: const Icon(Icons.add_chart),
            title: const Text(
              'Sự cố',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pop();
              navigatorPush(context, const IssuePage());
            },
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_rounded),
            title: const Text(
              'Báo cáo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pop();
              navigatorPush(context, const ReportPage());
            },
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
          ListTile(
            leading: const Icon(Icons.shield_rounded),
            title: const Text(
              'Đổi mật khẩu',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pop();
              navigatorPush(context,  ChangePasswordPage());
            },
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
          ListTile(
            leading: const Icon(Icons.ad_units_outlined),
            title: const Text(
              'Điều khoản',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text(
              'Liên hệ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text(
              'Đăng xuất',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              showConfirmDialog(
                  context: context,
                  message: 'Bạn có chắc chắn muốn đăng xuất',
                  onConfirm: () {
                    // progress.show();
                    logout();
                  });
            },
          ),
        ],
      ),
    );
  }

  void logout() {
    hive.remove(userKey);
    navigatorPushAndRemoveUntil(context, const LoginPage());
  }


}
