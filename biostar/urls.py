from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template
from django.conf import settings

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',

    # index page
    (r'^$', 'biostar.server.views.index'),

    ('^about/$', direct_to_template, {'template': 'about.html'}),
    ('^newquestion/$', direct_to_template, {'template': 'new.question.html'}),


    (r'^question/(?P<pid>\d+)/$', 'biostar.server.views.question'),
    (r'^newpost/$', 'biostar.server.views.newpost'),

    # Example:
    # (r'^biostar/', include('biostar.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # (r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # (r'^admin/', include(admin.site.urls)),

    (r'^static/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.STATIC_DIR }),
)