from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

from biostar.server import views

urlpatterns = patterns('',

    # This is the home page.
    url(r'^$', views.IndexView.as_view(), name="home"),



    # url(r'^biostar/', include('biostar.foo.urls')),

    # Social login pages.
    (r'^accounts/', include('allauth.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
)
