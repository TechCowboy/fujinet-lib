#include <stdint.h>
#include <string.h>
#include "fujinet-fuji.h"
#include "fujinet-bus-apple2.h"

bool fuji_get_ssid(NetConfig *net_config)
{
	sp_error = sp_get_fuji_id();
	if (sp_error <= 0) {
		return false;
	}

	sp_error = sp_status(sp_fuji_id, 0xFE);
	if (sp_error == 0) {
		memcpy(net_config, &sp_payload[0], sizeof(NetConfig));
	}
	return sp_error == 0;

}
