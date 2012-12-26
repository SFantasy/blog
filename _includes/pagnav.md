<nav>
  <div class="pagination">
  <ul>
  {% if paginator.previous_page %}
    {% if paginator.previous_page == 1 %}
      <li class="prev"><a href="/"></a></li>
    {% else %}
      <li class="prev"><a href="/page{{paginator.previous_page}}"></a></li>
    {% endif %}
  {% else %}
    <li class="prev"><a></a></li>
  {% endif %}
  {% if paginator.page == 1 %}
      <li><a>1</a></li>
  {% else %}
      <li><a href="/">1</a></li>
  {% endif %}
  {% for count in (2..paginator.total_pages) %}
      {% if count == paginator.page %}
      <li>{{count}}</li>
  {% else %}
      <li><a href="/page{{count}}">{{count}}</a></li>
      {% endif %}
  {% endfor %}
  {% if paginator.next_page %}
  <li class="next"><a href="/page{{paginator.next_page}}"></a></li>
  {% else %}
    <li class="next"></li>
  {% endif %}
  </ul>
  </div>
</nav>
