import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/sender_notice.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_sm_button.dart';
import 'package:flutter/material.dart';

class NoticeList extends StatelessWidget {
  final SenderNoticeModel notice;
  final Function()? historyOnPressed;
  final Function()? sendOnPressed;
  final Function()? modifyOnPressed;

  const NoticeList({
    required this.notice,
    this.historyOnPressed,
    this.sendOnPressed,
    this.modifyOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Card(
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notice.title,
                    style: const TextStyle(
                      color: kBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notice.content,
                    style: const TextStyle(
                      color: kBlackColor,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      notice.isSend
                          ? CustomSmButton(
                              label: '送信履歴',
                              labelColor: kWhiteColor,
                              backgroundColor: kCyanColor,
                              onPressed: historyOnPressed,
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          notice.isSend == false
                              ? CustomSmButton(
                                  label: '一斉送信',
                                  labelColor: kWhiteColor,
                                  backgroundColor: kCyanColor,
                                  onPressed: sendOnPressed,
                                )
                              : const CustomSmButton(
                                  label: '一斉送信',
                                  labelColor: kWhiteColor,
                                  backgroundColor: kGreyColor,
                                ),
                          const SizedBox(width: 8),
                          notice.isSend == false
                              ? CustomSmButton(
                                  label: '編集',
                                  labelColor: kWhiteColor,
                                  backgroundColor: kBlueColor,
                                  onPressed: modifyOnPressed,
                                )
                              : const CustomSmButton(
                                  label: '編集',
                                  labelColor: kWhiteColor,
                                  backgroundColor: kGreyColor,
                                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
