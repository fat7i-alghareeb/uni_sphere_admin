import 'package:beamer/beamer.dart';

import '../../../../../common/constant/app_strings.dart';
import '../../../../../router/router_config.dart' show BeamerBuilder;
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/announcement_entity.dart';
import '../widgets/announcement_details_content.dart';
import '../widgets/announcement_details_image.dart';

class AnnouncementDetailsScreen extends StatefulWidget {
  const AnnouncementDetailsScreen({
    super.key,
    required this.announcement,
  });

  final AnnouncementEntity announcement;
  static const String pagePath = 'announcement_details';

  static BeamerBuilder pageBuilder = (context, state, data) {
    final announcement = data as AnnouncementEntity?;
    if (announcement == null) {
      return BeamPage(
        key: const ValueKey('announcement_details_error'),
        type: BeamPageType.fadeTransition,
        child: Scaffold(
          body: Center(
            child: Text(AppStrings.newsNotFound),
          ),
        ),
      );
    }
    return BeamPage(
      key: ValueKey('announcement_details_${announcement.id}'),
      child: AnnouncementDetailsScreen(announcement: announcement),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<AnnouncementDetailsScreen> createState() =>
      _AnnouncementDetailsScreenState();
}

class _AnnouncementDetailsScreenState extends State<AnnouncementDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;
  bool _isDisposed = false;
  bool _hasAnimated = false;
  String? _selectedImageUrl;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _selectedImageUrl = widget.announcement.image?.firstOrNull;
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animations = List.generate(
      2, // Header and Content
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * (0.5 / 2),
            (index * (0.5 / 2)) + 0.5,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    if (!_isDisposed && !_hasAnimated) {
      _controller.forward();
      _hasAnimated = true;
    }
  }

  void _handleImageSelection(String imageUrl) {
    setState(() {
      _selectedImageUrl = imageUrl;
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _hasAnimated = false;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AnnouncementDetailsImage(
            id: widget.announcement.id,
            imageUrl: _selectedImageUrl ?? '',
            images: widget.announcement.image ?? [],
            selectedImageUrl: _selectedImageUrl,
            onImageSelected: _handleImageSelection,
          ),
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _animations.last,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -20 * (1 - _animations.last.value)),
                  child: Opacity(
                    opacity: _animations.last.value,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: REdgeInsets.symmetric(vertical: 9.0),
                child: AnnouncementDetailsContent(
                  announcement: widget.announcement,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
