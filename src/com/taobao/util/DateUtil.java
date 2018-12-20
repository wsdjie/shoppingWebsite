package com.taobao.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	/**
	 * 将时间格式化成长字符串
	 * @param date
	 * @return
	 */
	public static String formateDateToLongDateStr(Date date)
	{
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
	}
}
