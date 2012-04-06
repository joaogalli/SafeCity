package br.com.i4people.safecity.component;

import android.content.Context;
import android.content.Intent;
import android.content.res.TypedArray;
import android.os.Bundle;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;
import br.com.i4people.safecity.BairroDetailActivity;
import br.com.i4people.safecity.R;
import br.com.i4people.safecity.activity.AvisoLegalActivity;
import br.com.i4people.safecity.activity.HospitalActivity;
import br.com.i4people.safecity.activity.PersonalActivity;
import br.com.i4people.safecity.activity.PoliciaActivity;
import br.com.i4people.safecity.activity.SettingsActivity;

/**
 * @author joaoeduardogalli
 * 
 */
public class Toolbar extends LinearLayout {

	private static Bundle bairro;

	public Toolbar(final Context context) {
		super(context);
	}

	public Toolbar(final Context con, AttributeSet attrs) {
		super(con, attrs);
		setOrientation(HORIZONTAL);
		setBackgroundColor(getResources().getColor(android.R.color.transparent));

		LayoutInflater inflater = (LayoutInflater) con.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		inflater.inflate(R.layout.navigation, this);

		TypedArray a = con.obtainStyledAttributes(attrs, R.styleable.Toolbar);
		String option = a.getString(R.styleable.Toolbar_tab_id);

		String resourceId = "br.com.i4people.safecity:id/" + option;
		int optionId = getResources().getIdentifier(resourceId, null, null);

		TextView currentOption = (TextView) findViewById(optionId);
		if (currentOption != null) {
			currentOption.setBackgroundColor(0x22CCCCCC);
			currentOption.setTextColor(getResources().getColor(android.R.color.white));
			currentOption.requestFocus(optionId);
			currentOption.setFocusable(false);
			currentOption.setClickable(false);
		}

		TextView tab1 = (TextView) findViewById(R.id.disclaimerToolbarOption);
		tab1.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				Intent intent = new Intent(con, AvisoLegalActivity.class);
				con.startActivity(intent);
			}
		});

		TextView tab2 = (TextView) findViewById(R.id.configuracoesToolbarOption);
		tab2.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				Intent intent = new Intent(con, SettingsActivity.class);
				con.startActivity(intent);
			}
		});

		TextView tab3 = (TextView) findViewById(R.id.policiaToolbarOption);
		tab3.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				Intent intent = new Intent(con, PoliciaActivity.class);
				intent.putExtra(BairroDetailActivity.BAIRRO, bairro);
				con.startActivity(intent);
			}
		});

		TextView tab4 = (TextView) findViewById(R.id.hospitalToolbarOption);
		tab4.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				Intent intent = new Intent(con, HospitalActivity.class);
				intent.putExtra(BairroDetailActivity.BAIRRO, bairro);
				con.startActivity(intent);
			}
		});

		TextView tab5 = (TextView) findViewById(R.id.personalToolbarOption);
		tab5.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				Intent intent = new Intent(con, PersonalActivity.class);
				con.startActivity(intent);
			}
		});
	}

	public Bundle getBairro() {
		return bairro;
	}

	public void setBairro(Bundle bairro) {
		this.bairro = bairro;
	}

}
