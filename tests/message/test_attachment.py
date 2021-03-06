# -*- coding: utf-8 -*-
import os

from hamcrest import assert_that, has_entries, not_none

from pyworkplace.config import ASSETS_DIR
from pyworkplace.message import Attachment

RECIPIENT_ID = '10000000'


def test_send_image():
    params = {
        'version': 'v2.8',
        'access_token': 'this is my token',
    }
    message = Attachment(**params)
    image_path = os.path.join(ASSETS_DIR, 'test.jpg')

    args = {
        'recipient_id': RECIPIENT_ID,
        'image_path': image_path,
    }
    assert_that(
        message.send_image(**args),
        not_none(),
    )

    body = {
        'message': {
            'attachment': {
                'type': 'image',
                'payload': {},
            },
        },
        'filedata': '@/usr/src/tests/resources/assets/test.jpg;type=image/jpeg',
        'recipient': {'id': RECIPIENT_ID},
        'notification_type': 'REGULAR',
    }
    response = {
        'url': 'https://graph.facebook.com/v2.8/me/messages',
        'params': {'access_token': params['access_token']},
        'data': body,
    }

    assert_that(
        response,
        has_entries(message.response),
    )
