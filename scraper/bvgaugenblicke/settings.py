#    BVG Augenblicke Spider: Download flirt moments from bvg.de/augenblicke
#    Copyright (C) 2013 gitsbug
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Scrapy settings for bvgaugenblicke project
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/topics/settings.html
#

BOT_NAME = 'bvgaugenblicke'
BOT_VERSION = '1.0'

SPIDER_MODULES = ['bvgaugenblicke.spiders']
NEWSPIDER_MODULE = 'bvgaugenblicke.spiders'
DEFAULT_ITEM_CLASS = 'bvgaugenblicke.items.BvgaugenblickeItem'
USER_AGENT = '%s/%s' % (BOT_NAME, BOT_VERSION)

