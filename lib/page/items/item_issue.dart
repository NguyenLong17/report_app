import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:report_app/common/const/const.dart';
import 'package:report_app/model/account_public.dart';
import 'package:report_app/model/issue.dart';

class ItemIssue extends StatelessWidget {
  final Issue issue;
  final AccountPublic accountPublic;

  Color? colorStatus;
  String? textStatus;

  ItemIssue({
    super.key,
    required this.issue,
    required this.accountPublic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          top: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
          right: BorderSide(),
          bottom: BorderSide(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: userPublic(),
                ),
                if (issue.status == 0) ...{
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Đã duyệt',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                } else if (issue.status == 1) ...{
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Chưa duyệt',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                },
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            Text(
              issue.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(issue.content ?? ''),
            const SizedBox(
              height: 8,
            ),
            buildListImage(),
          ],
        ),
      ),
    );
  }

  Widget userPublic() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (issue.accountPublic!.avatar!.startsWith(baseUrl)) ...{
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(),
                child: Image.network(
                  issue.accountPublic!.avatar!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          } else ...{
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(),
                child: Image.network(
                  baseUrl + issue.accountPublic!.avatar!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          },
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                issue.accountPublic!.name ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                issue.createdAt ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildListImage() {
    if (issue.photos!.length == 1) {
      return GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          final image = issue.photos![index];
          if (image.startsWith(baseUrl)) {
            return Image.network(
              image,
              fit: BoxFit.cover,
            );
          } else if (isImage(image)) {
            return Image.network(
              baseUrl + image,
              fit: BoxFit.cover,
            );
          }
          return const SizedBox.expand();
        },
        itemCount: 1,
      );
    } else if (1 < issue.photos!.length && issue.photos!.length < 5) {
      return GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          final image = issue.photos![index];
          if (image.startsWith(baseUrl)) {
            return Image.network(
              image,
              fit: BoxFit.cover,
            );
          } else if (isImage(image)) {
            return Image.network(
              baseUrl + image,
              fit: BoxFit.cover,
            );
          }
          return const SizedBox.expand();
        },
        itemCount: issue.photos!.length,
      );
    } else if (issue.photos!.length >= 5) {
      return GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          final image = issue.photos![index];

          if (image.startsWith(baseUrl)) {
            if (image == issue.photos![3]) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                  ClipRRect(
                    // Clip it cleanly.
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Container(
                        color: Colors.grey.withOpacity(0.8),
                        alignment: Alignment.center,
                        child: Text(
                          '+${issue.photos!.length - 4}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Image.network(
              image,
              fit: BoxFit.cover,
            );
          }
          //Tao
          else if (isImage(image)) {
            if (image == issue.photos![3]) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    baseUrl + image,
                    fit: BoxFit.cover,
                  ),
                  ClipRRect(
                    child: Container(
                      color: Colors.grey.withOpacity(0.8),
                      alignment: Alignment.center,
                      child: Text(
                        '+${issue.photos!.length - 4}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Image.network(
              baseUrl + image,
              fit: BoxFit.cover,
            );
          }
          return const SizedBox.shrink();
        },
        itemCount: 4,
      );
    }
    return const SizedBox.shrink();
  }

  bool isImage(String path) {
    //baseUrl + path
    if (path.isEmpty || path.length <= 5) {
      // anh loi "" , "''"
      lookupMimeType(path);
      return false;
    } else if (path.isNotEmpty && path.startsWith('https')) {
      // anh web: http khong loi
      lookupMimeType(path);
      return false;
    } else if (path.isNotEmpty) {
      // anh khong co baseUrl
      lookupMimeType(baseUrl + path);
      return true;
    }
    return false;
  }
}
