import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';

class ExploreRemoteDataSource {
  Future<List<NearbyMessage>> getNearbyMessages({
    required double radiusKm,
  }) async {
    // TODO: API - Replace with actual Firestore geoflutterfire_plus query
    // Query: messages within radiusKm of current user location
    return [
      NearbyMessage(
        id: '1',
        authorName: 'Elias Thorne',
        authorPhotoUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAhovxgEAfFEs7ZDsaIUgmyYVlx_Y6_lEKJ3FfUceKMWeSPk2PlLj0pPQP6VvhgtsTI8vW4SReo1wYdH0bGRaIEzBBOhXhgsY11ud23sAXh0MOZc2iJuG2fmumZidLw5JtbBbZsJRkTJXE53xB39r7axQcnyqYol721-17b1qwuFMN1MAnk6UVxuf6IdV32AshciW9wtKLYzAjmxB6BZ5UXkVRSOUAjY_b11RX7Zc4LpxeH3F21KAMVCWyPtCMOrxmjm4E2JM3VhLw',
        text:
            'If you sit by the old oak tree near the creek just as the sun dips, the light hits the water exactly like a spilled jar of honey. Found a small stone carving left by someone else here. Stayed for an hour.',
        timeAgo: '2 mins ago',
        distance: '0.3km',
        likeCount: 12,
        commentCount: 4,
        isPinned: true,
      ),
      NearbyMessage(
        id: '2',
        authorName: 'Martha G.',
        authorPhotoUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuA1DXGxTaYj3Y4bOR0n7UPVP3t6_HLh2EexrKiuAsawAb2oNmwULwC3WL672SvL-APZV2B1dBgtVC6_Tl_FsCOUK6smYBFqEQCakCrrifk4mSdpIiivBh7QE5j8IrhlWjJz1ow6kgfbUmgj-cqnRqpEfGryt27241xkiuQfOgxKlR0i4jqIxs-WZWyBmKyIQLq9Tu3FYKRUBkjisi0YjUcC9N2HEuOSayBQXFXyA4qzwzRsyonKZzDbgRMTAoEF0tes1RYgGYdfdRk',
        text:
            'The local bakery just put out a fresh batch of lavender shortbread. The smell is drifting all the way to the park bench.',
        timeAgo: '15 mins ago',
        distance: '0.5km',
        hashtag: '#localfinds',
      ),
      NearbyMessage(
        id: '3',
        authorName: 'Julian Wu',
        authorPhotoUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAxvwzi2L60NOkKsaKJZIeT13SovADvHs9hhnlqfIHE7h5_ouOLhy27lkPlyMZKZ1vvqsJs5oXOOcOAgZ3PQTJnhPQR_z-F1E3HcQdMFjrXtNKDXy7EmcUgfC91rWUUI6dc23GTqQU7BUFkly3UeMO6fjYz_KSVjve3ENWAvIBAv4j7Le7HoOMOQEkTksInwSbAs-jhTBG_5K6zFPVU0qL3Sg0gulj7t_7au5B404O9H9V8nNUKrfq92I6iTXBrZs7E8OJ8orDWz5I',
        text:
            'Found the perfect reading spot hidden behind the community garden. Complete silence except for the bees.',
        timeAgo: '1 hour ago',
        distance: '0.8km',
        hashtag: '#quietcorner',
      ),
      NearbyMessage(
        id: '4',
        authorName: 'Community Note',
        text:
            'Weekly gathering at the square for the lantern walk starts in two hours. Everyone is welcome to bring a light.',
        timeAgo: '3 hours ago',
        distance: '0.2km',
        isCommunityNote: true,
      ),
      NearbyMessage(
        id: '5',
        authorName: 'Sara L.',
        authorPhotoUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDnUHhtWIHQs6ctMXtp091B01pgNMR59WDaeFFRkFcMuUpK6SXbbXUclYphLbNZ6h6RQb313GnECXP3xep1D5ZvZkkkbND--SdTeE93NBOE_-9ja4sLV5X9U7Tah6hOEwsun0lbse0rT93YKYaNmYKy8bQZ7MDD6K7SjgRt9togyYQ4UvSg7x2E5MFyR60rUteeIZnY0USbhfKhzG5wTpSIIFc6pNuJaNOL8d8V6pNJcIovmq8EapGr8739fCqs1LbNLafmjUddjXs',
        text:
            'The fog this morning made the bridge look like it was floating. Captured some beautiful film shots if anyone wants to see.',
        timeAgo: '4 hours ago',
        distance: '1.1km',
        hashtag: '#morningfog',
      ),
    ];
  }
}
