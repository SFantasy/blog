<aside>
<div class="page-sidebar">
      <ul>
        <li>
          <a>分类目录</a>
          <ul class="sub-menu light">
              {% for cat in site.categories %}
                <li><a href="/categories.html#{{ cat[0] }}-ref" title="{{ cat[0] }}" rel="{{ cat[1].size }}">{{ cat[0] }} <sup>({{ cat[1].size }})</sup></a></li>
              {% endfor %}
          </ul>
        </li>
        <li>
          <a>近期文章</a>
          <ul class="sub-menu light">
            {% for post in site.posts limit: 5 %}
              <li><a href="{{ post.url }}" title="{{ post.title }}">{{ post.title }}</a></li>
            {% endfor %}
          </ul>
        </li>
        <li>
          <a>近期评论</a>
          <ul class="sub-menu light">
            <script type="text/javascript" src="http://027.disqus.com/recent_comments_widget.js?num_items=5&hide_avatars=0&avatar_size=32&excerpt_length=50">
            </script>
          </ul>
        </li>
        <li>
          <a>友情链接</a>
          <ul class="sub-menu light">
            <li><a href="http://www.google.com">Google</a></li>
          </ul>
        </li>
      </ul>
</div>
</aside>
