import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

class Repository {
  final supabaseClient = Get.find<SupabaseClient>();

  getClass(int gymId) async {
    print('get class ran');
    final res = await supabaseClient.from('classes').select('''
    *, gyms (
      name, location
    )''').eq('id', gymId).execute();
    print("classes data: ${res.data}");
    final error = res.error;
    if (error == null) {
      return res.data;
    } else {
      throw Error();
    }
  }

  getGymsList() async {
    final res = await supabaseClient.from('gyms').select().execute();
    print("gyms list: ${res.data}");
    final error = res.error;
    if (error == null) {
      return res.data;
    } else {
      throw Error();
    }
  }
}
