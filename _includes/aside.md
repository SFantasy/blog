<aside>
<div class="page-sidebar">
      <ul>
        <li>
          <a><i class="icon-bookmark-2"></i> Categories</a>
          <ul class="sub-menu light">
              {% for cat in site.categories %}
                <li><a href="/categories.html#{{ cat[0] }}-ref" title="{{ cat[0] }}" rel="{{ cat[1].size }}">{{ cat[0] }} <sup>({{ cat[1].size }})</sup></a></li>
              {% endfor %}
          </ul>
        </li>
        <li>
          <a><i class="icon-book"></i> Recent Posts</a>
          <ul class="sub-menu light">
            {% for post in site.posts limit: 5 %}
              <li><a href="{{ post.url }}" title="{{ post.title }}">{{ post.title }}</a></li>
            {% endfor %}
          </ul>
        </li>
        <li>
          <a><i class="icon-comments-5"></i> Recent Comments</a>
          <ul class="sub-menu light">
            <script type="text/javascript" src="http://027.disqus.com/recent_comments_widget.js?num_items=5&hide_avatars=0&avatar_size=32&excerpt_length=50">
            </script>
          </ul>
        </li>
        <li>
          <a><i class="icon-link"></i> Links</a>
          <ul class="sub-menu light">
            <li><a href="http://www.google.com">Google</a></li>
            <li><a href="http://fantasy00.diandian.com">My Diandian Blog</a></li>
          </ul>
        </li>
      </ul>
</div>
</aside>
