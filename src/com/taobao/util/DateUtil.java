package com.taobao.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	/**
	 * ��ʱ���ʽ���ɳ��ַ���
	 * @param date
	 * @return
	 */
	public static String formateDateToLongDateStr(Date date)
	{
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
	}
}
