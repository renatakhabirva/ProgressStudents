//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProgressStudents
{
    using System;
    using System.Collections.Generic;
    
    public partial class Teachers
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Teachers()
        {
            this.Discipline = new HashSet<Discipline>();
            this.Summary = new HashSet<Summary>();
        }
    
        public int TeacherID { get; set; }
        public string TeacherFullName { get; set; }
        public string TeacherPost { get; set; }
        public Nullable<int> TeacherExperience { get; set; }
        public int TeacherPulpit { get; set; }
        public System.DateTime TeacherDayOfBirth { get; set; }
        public Nullable<System.DateTime> TeacherDayWork { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Discipline> Discipline { get; set; }
        public virtual Pulpit Pulpit { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Summary> Summary { get; set; }
    }
}
