import 'dart:math';

import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/individual_members_response.dart';

import 'package:flutter/material.dart';

class IndividualMembersProvider extends BaseProvider {
  bool isLoad = false;
  List<IndividualMembersData> individualMembersData = [];

  Future<void> fetchIndividualMember() async {
    try {
      isLoad = true;
      notifyListeners();

      final response =
      await authRepository.individualUMembers();

      print('Response => ${response.data}');
      print('Error => ${response.error}');

      if (response.isSuccess == true) {

        final List rowData =
            response.data['data'] ?? [];

        individualMembersData = rowData
            .map(
              (e) => IndividualMembersData.fromJson(e),
        )
            .toList();

        print(
          'Total Members => ${individualMembersData.length}',
        );
      }
    } catch (error) {
      print('Fetch Error => $error');
    } finally {
      isLoad = false;
      notifyListeners();
    }
  }
  Future<void> individualDeleteMember(
      BuildContext context,
      int id,
      ) async {
    try {

      final response =
      await authRepository.individualDeleteMembers(
        id,
      );
      print('adnfdsajbfk=> ${response.data}');
      print('adnfdsajbfk=> ${response.error}');

      if (response.isSuccess == true) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.data['message'] ??
                  'Member deleted successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );

        await Future.delayed(
          const Duration(milliseconds: 500),
        );

        fetchIndividualMember();

      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.data['message'] ??
                  'Failed to delete member',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }

    } catch (error) {

      print('Delete Error => $error');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

}
