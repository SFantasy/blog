<nav>
  {% if paginator.previous_page %}
    {% if paginator.previous_page == 1 %}
      <span><a href="/"><前页</a></span>
    {% else %}
      <span><a href="/page{{paginator.previous_page}}"><前页</a></span>
    {% endif %}
  {% else %}
    <span><前页</span>
  {% endif %}
  {% if paginator.page == 1 %}
      <span>1</span>
  {% else %}
      <a href="/">1</a>
  {% endif %}
  {% for count in (2..paginator.total_pages) %}
      {% if count == paginator.page %}
      <span>{{count}}</span>
  {% else %}
      <a href="/page{{count}}">{{count}}</a>
      {% endif %}
  {% endfor %}
  {% if paginator.next_page %}
  <span><a href="/page{{paginator.next_page}}">后页></a></span>
  {% else %}
    <span>后页></span>
  {% endif %}
  (共{{ paginator.total_posts }}篇)
</nav>
